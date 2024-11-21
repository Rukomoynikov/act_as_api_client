# frozen_string_literal: true

module ActAsApiClient
  class ClientLoader
    attr_reader :client_for

    def initialize(client_for:)
      @client_for = client_for
    end

    def class_name
      case client_for.class.to_s
      when "String", "Symbol"
        "#{convert_underscore_to_camelcase(client_for)}Client"
      when "Array"
        client_for
          .map { |item| convert_underscore_to_camelcase(item) }
          .join("::")
          .concat("Client")
      end
    end

    def path
      case client_for.class.to_s
      when "String", "Symbol"
        File.expand_path("clients/#{client_for}_client", File.dirname(__FILE__))
      when "Array"
        client_path = client_for.join("/")

        File.expand_path("clients/#{client_path}_client", File.dirname(__FILE__))
      end
    end

    private

    # Converting from authorize_net_webhooks_client to AuthorizeNetWebhooksClient
    #
    # @param value [String] string with underscores
    # @return [String] transformed in camel case format string
    def convert_underscore_to_camelcase(value)
      value.to_s.capitalize.gsub(/_(.)/) do |s|
        s.upcase.gsub("_", "")
      end
    end
  end
end
