# frozen_string_literal: true

require_relative "http_client"
require "base64"

module ActAsApiClient
  module Clients
    module AuthorizeNetWebhooksClient
      include HttpClient
      DEFAULT_OPTIONS = {
        mode: :production
      }.freeze

      def initialize
        @options = DEFAULT_OPTIONS.merge(options)
      end

      def find(uuid)
        raise StandardError, "uuid is not provided" if uuid.empty?

        get("https://#{base_uri}/rest/v1/webhooks/#{uuid}",
            headers: { "Authorization" => auth })
      end

      private

      def base_uri
        if @options[:mode] == :test
          "apitest.authorize.net"
        else
          "authorize.net"
        end
      end

      def auth
        if options[:payment_user]
          "Basic #{Base64.strict_encode64("#{options[:payment_user]}:#{options[:payment_pass]}")}"
        end
      end
    end
  end
end
