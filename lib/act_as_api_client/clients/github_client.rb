# frozen_string_literal: true

require_relative "http_client"
require "httparty"

module ActAsApiClient
  module Clients
    module GithubClient
      include HttpClient
      def find(repository_name)
        unless repository_name.match?(%r{[a-zA-Z]/[a-zA-Z]})
          raise StandardError, "repository_name parameter is not valid"
        end

        HTTParty
          .get(
            "https://api.github.com/repos/#{repository_name}",
            headers: { "Content-Type" => "application/json", "Accept" => "application/vnd.github.v3+json" }
          )
          .parsed_response
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
