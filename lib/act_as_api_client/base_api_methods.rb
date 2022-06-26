# frozen_string_literal: true

module ActAsApiClient
  module BaseApiMethods
    def find
      raise StandardError, "Should be defined in inherited class"
    end

    def where
      raise StandardError, "Should be defined in inherited class"
    end

    def find_by
      raise StandardError, "Should be defined in inherited class"
    end

    def delete
      raise StandardError, "Should be defined in inherited class"
    end

    def create
      raise StandardError, "Should be defined in inherited class"
    end

    def update
      raise StandardError, "Should be defined in inherited class"
    end
  end
end
