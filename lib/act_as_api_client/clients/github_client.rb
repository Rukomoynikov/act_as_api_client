# frozen_string_literal: true

require "httparty"

module ActAsApiClient
  module Clients
    module GithubClient
      def find
        "find"
      end

      def where
        "where"
      end

      def find_by
        "find_by"
      end

      def delete
        "delete"
      end

      def create
        "create"
      end

      def update
        "update"
      end
    end
  end
end
