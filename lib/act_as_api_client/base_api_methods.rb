# frozen_string_literal: true

module ActAsApiClient
  module BaseApiMethods
    # https://apidock.com/rails/ActiveRecord/Base/find/class
    def find
      raise StandardError, "Should be defined in inherited class"
    end

    # https://apidock.com/rails/ActiveRecord/QueryMethods/where
    def where
      raise StandardError, "Should be defined in inherited class"
    end

    # https://apidock.com/rails/ActiveRecord/FinderMethods/find_by
    def find_by
      raise StandardError, "Should be defined in inherited class"
    end

    # https://apidock.com/rails/ActiveRecord/Relation/delete
    def delete
      raise StandardError, "Should be defined in inherited class"
    end

    # https://apidock.com/rails/ActiveRecord/Base/create/class
    def create
      raise StandardError, "Should be defined in inherited class"
    end

    # https://apidock.com/rails/ActiveRecord/Base/update/class
    def update
      raise StandardError, "Should be defined in inherited class"
    end
  end
end