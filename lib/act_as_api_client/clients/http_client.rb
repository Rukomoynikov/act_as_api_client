# frozen_string_literal: true

require "net/http"
require "json"

require "act_as_api_client/errors/invalid_response_error"
require "act_as_api_client/errors/network_error"

module ActAsApiClient
  module Clients
    module HttpClient
      private

      def get(url, **options)
        # Request part
        uri = URI(url)
        uri.query = URI.encode_www_form(options.fetch(:params, {}))

        request = Net::HTTP::Get.new(uri)
        set_request_headers(headers: options.fetch(:headers, {}),
                            request: request)

        # Response part
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        case response
        when Net::HTTPNotFound, Net::HTTPSuccess, Net::HTTPUnprocessableEntity, Net::HTTPUnauthorized
          ::JSON.parse(response.body)
        end
      end

      def post(url, headers: {}, **options) # rubocop:disable Metrics/AbcSize
        # Request part
        uri = URI(url)
        uri.query = URI.encode_www_form(options.fetch(:params, {}))

        request = Net::HTTP::Post.new(uri)

        request.body = options.fetch(:body, {}).to_json
        set_request_headers(headers: headers, request: request)

        # Response part
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        case response
        when Net::HTTPSuccess, Net::HTTPBadRequest
          ::JSON.parse(response.body)
        when Net::HTTPNotFound, Net::HTTPUnprocessableEntity, Net::HTTPUnauthorized
          ::JSON.parse(response.body)
        end
      rescue Net::OpenTimeout, Net::ReadTimeout, SocketError => e
        raise ActAsApiClient::NetworkError, "Network error occurred: #{e.message}"
      rescue JSON::ParserError => e
        raise ActAsApiClient::InvalidResponseError, "Invalid JSON response: #{e.message}"
      end

      def set_request_headers(headers:, request:)
        headers.each do |key, value|
          request[key] = value
        end
      end
    end
  end
end
