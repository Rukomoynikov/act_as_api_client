# frozen_string_literal: true
#
module ActAsApiClient
  module BaseApiMethods
    def find
      raise StandardError.new "Should be defined in inherited class"
    end

    def where
      raise StandardError.new "Should be defined in inherited class"
    end

    def find_by
      raise StandardError.new "Should be defined in inherited class"
    end

    def delete
      raise StandardError.new "Should be defined in inherited class"
    end

    def create
      raise StandardError.new "Should be defined in inherited class"
    end

    def update
      raise StandardError.new "Should be defined in inherited class"
    end
  end
end