# frozen_string_literal: true

require "net/http"
require "json"

require "act_as_api_client/errors/invalid_response_error"
require "act_as_api_client/errors/network_error"

require "act_as_api_client/clients/http/base_client"

module ActAsApiClient
  module Clients
    module Http
      class SimpleClient
        include BaseClient

        def get(url, **options)
          uri = build_uri(url, **options)

          request = Net::HTTP::Get.new(uri)
          set_request_headers(headers: options.fetch(:headers, {}),
                              request: request)

          response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end

          parse_response(response)
        end

        def post(url, headers: {}, **options)
          uri = build_uri(url, **options)
          request = Net::HTTP::Post.new(uri)
          set_request_headers(headers: headers, request: request)
          request.body = options.fetch(:body, {}).to_json

          response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end

          parse_response(response)
        end

        private

        def parse_response(response)
          case response
          when Net::HTTPSuccess, Net::HTTPBadRequest
            ::JSON.parse(response.body)
          when Net::HTTPNotFound, Net::HTTPUnprocessableEntity, Net::HTTPUnauthorized
            ::JSON.parse(response.body)
          end
        rescue Net::OpenTimeout, Net::ReadTimeout, SocketError => e
          raise ActAsApiClient::Errors::NetworkError, "Network error occurred: #{e.message}"
        rescue JSON::ParserError => e
          raise ActAsApiClient::Errors::InvalidResponseError, "Invalid JSON response: #{e.message}"
        end
      end
    end
  end
end
