# frozen_string_literal: true

require_relative "lib/act_as_api_client"

class GithubClient < ApiClient
  act_as_api_client for: :github_repositories
end

p GithubClient.ancestors
p GithubClient.new.method(:find).source_location

GithubClient.new.find
