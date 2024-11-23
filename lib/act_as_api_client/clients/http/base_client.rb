# frozen_string_literal: true

module ActAsApiClient
  module Clients
    module Http
      module BaseClient
        private

        def build_uri(url, **options)
          uri = URI(url)
          uri.query = URI.encode_www_form(options.fetch(:params, {}))

          uri
        end

        def set_request_headers(headers:, request:)
          headers.each do |key, value|
            request[key] = value
          end
        end
      end
    end
  end
end
