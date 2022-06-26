# frozen_string_literal: true

require_relative "act_as_api_client/version"
require_relative "act_as_api_client/base_api_methods"

module ActAsApiClient
  class Error < StandardError; end
  class ClientFileExistingError < StandardError; end
  module ClassMethods
    def act_as_api_client(**args)
      client_for = args.fetch(:for, nil)

      unless client_for.nil?
        file_path = "act_as_api_client/clients/#{client_for}_client"

        raise ClientFileExistingError unless File.exist?(Pathname.new(file_path))

        is_loaded = require_relative file_path
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  include BaseApiMethods
end

class Object
  include ActAsApiClient
end
