# frozen_string_literal: true

require_relative "act_as_api_client/base_api_methods"
require "act_as_api_client/errors/non_existing_client_error"
require "act_as_api_client/client_loader"

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

      client_loader = ActAsApiClient::ClientLoader.new(client_for: client_for)

      require(client_loader.path)
      include const_get("ActAsApiClient::Clients::#{client_loader.class_name}")
    rescue LoadError
      raise ActAsApiClient::Errors::NonExistingClient.new(requested_client: client_for)
    end

    def set_options(options:)
      define_method("options") { options }
    end
  end
end
