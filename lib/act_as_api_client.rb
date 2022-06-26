# frozen_string_literal: true

require_relative "act_as_api_client/version"
require_relative "act_as_api_client/base_api_methods"

module ActAsApiClient
  include BaseApiMethods

  module ClassMethods
    def act_as_api_client(**args)
      client_for = args.fetch(:for, nil)

      unless client_for.nil?
        require(File.expand_path("act_as_api_client/clients/#{client_for}_client",
                                 File.dirname(__FILE__)))
        include ActAsApiClient::Clients::GithubClient
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

class ApiClient
  include ActAsApiClient
end
