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

        HTTParty.get("https://api.github.com/repos/#{repository_name}",
                     headers: { "Content-Type" => "application/json",
                                "Accept" => "application/vnd.github.v3+json",
                                "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) })
                .parsed_response
      end

      def where
        "where"
      end

      def find_by(_options = {})
        # by_organization https://docs.github.com/en/rest/repos/repos#list-organization-repositories
        # by_user https://docs.github.com/en/rest/repos/repos#list-repositories-for-a-user
        # by_authenticated_user https://docs.github.com/en/rest/repos/repos#list-repositories-for-the-authenticated-user
        "find_by"
      end

      def delete
        # Call only on queried before repository and repository is not 404/400 and has right to delete (write)
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
