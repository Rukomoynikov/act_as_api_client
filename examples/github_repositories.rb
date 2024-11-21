# frozen_string_literal: true

# Run it with `ruby github_repositories.rb`

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  gem "act_as_api_client", path: "./"
  gem "tabled"
end

require "act_as_api_client"

class GithubApiClient < ApiClient
  act_as_api_client for: :github_repositories
end

github_api_client = GithubApiClient.new
pp github_api_client.find("Rukomoynikov/tabled")
