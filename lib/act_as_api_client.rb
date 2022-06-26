# frozen_string_literal: true

require_relative "act_as_api_client/version"
require_relative "act_as_api_client/base_api_methods"

module ActAsApiClient
  class Error < StandardError; end
  module ClassMethods
    def act_as_api_client
      puts "class hello"
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