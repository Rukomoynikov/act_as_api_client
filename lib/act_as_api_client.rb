# frozen_string_literal: true

require_relative "act_as_api_client/base_api_methods"

class ApiClient
  include ActAsApiClient::BaseApiMethods

  class << self
    def act_as_api_client(**args)
      set_general_client(client_for: args.fetch(:for, nil))
      set_options(options: args.fetch(:with, {}))
    end

    private

    def set_general_client(client_for:)
      return if client_for.nil?

      class_name = convert_underscore_to_camelcase(client_for)

      require(File.expand_path("act_as_api_client/clients/#{client_for}_client",
                               File.dirname(__FILE__)))
      include const_get("ActAsApiClient::Clients::#{class_name}Client")
    end

    def set_options(options:)
      define_method("options") { options }
    end

    # Converting from authorize_net_webhooks_client to AuthorizeNetWebhooksClient
    #
    # @param value [String] string with underscores
    #
    # @return [String] transformed in camel case format string
    def convert_underscore_to_camelcase(value)
      value.to_s.capitalize.gsub(/_(.)/) do |s|
        s.upcase.gsub("_", "")
      end
    end
  end
end
