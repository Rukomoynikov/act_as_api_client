# frozen_string_literal: true

require "net/http"
require "json"
require "event_stream_parser"

require "act_as_api_client/errors/invalid_response_error"
require "act_as_api_client/errors/network_error"

module ActAsApiClient
  module Clients
    module Http
      class StreamingClient
        include BaseClient

        def post(url, headers: {}, **options) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          uri = URI(url)
          uri.query = URI.encode_www_form(options.fetch(:params, {}))

          request = Net::HTTP::Post.new(uri)

          request.body = options.fetch(:body, {}).to_json
          set_request_headers(headers: headers, request: request)

          parser = EventStreamParser::Parser.new

          Net::HTTP.start(uri.hostname, use_ssl: true) do |http|
            http.request(request) do |response|
              case response
              when Net::HTTPSuccess, Net::HTTPBadRequest
                response.read_body do |chunk|
                  parser.feed(chunk) do |_type, data, _id, _reconnection_time|
                    yield(::JSON.parse(data)) if block_given?
                  end
                end
              when Net::HTTPNotFound, Net::HTTPUnprocessableEntity, Net::HTTPUnauthorized
                response.read_body do |chunk|
                  parser.feed(chunk) do |_type, data, _id, _reconnection_time|
                    yield(::JSON.parse(data)) if block_given?
                  end
                end
              end
            end
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
