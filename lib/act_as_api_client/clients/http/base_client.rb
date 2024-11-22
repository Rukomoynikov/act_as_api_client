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
      end
    end
  end
end
