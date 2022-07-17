# frozen_string_literal: true

require "net/http"
require "json"

module ActAsApiClient
  module Clients
    module HttpClient
      private

      def get(url, options = {})
        # Request part
        uri = URI(url)
        uri.query = URI.encode_www_form(options.fetch(:params, {}))

        request = Net::HTTP::Get.new(uri)
        request_headers(headers: options.fetch(:headers, {}),
                        request: request)

        # Response part
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        case response
        when Net::HTTPNotFound, Net::HTTPSuccess, Net::HTTPUnprocessableEntity
          ::JSON.parse(response.body)
        end
      end

      def post
        # HTTParty.post
      end

      def put
        # HTTParty.put
      end

      def update
        # HTTParty.update
      end

      def delete
        # HTTParty.delete
      end

      def request_headers(headers:, request:)
        headers.each do |key, value|
          request[key] = value
        end
      end
    end
  end
end
