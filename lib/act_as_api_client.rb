# frozen_string_literal: true

require_relative "act_as_api_client/version"
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
      unless client_for.nil?
        require(File.expand_path("act_as_api_client/clients/#{client_for}_client",
                                 File.dirname(__FILE__)))
        include const_get("ActAsApiClient::Clients::#{client_for.capitalize}Client")
      end
    end

    def set_options(options:)
      define_method("options") { options }
    end
  end
end
