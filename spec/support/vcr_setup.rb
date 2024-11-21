# frozen_string_literal: true

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data("<GITHUB_TOKEN>") { YAML.load_file("spec/credentials.yml").dig("github", "token") }
  config.filter_sensitive_data("<AUTHORIZE_AUTH_HEADER>") { YAML.load_file("spec/credentials.yml").dig("authorize", "basic_auth") }

  # https://github.com/vcr/vcr/issues/898
  config.filter_sensitive_data("<X-Api-Key>") do |interaction|
    interaction
      .request
      .headers["X-Api-Key"] = YAML.load_file("spec/credentials.yml").dig("anthropic", "messages", "x-api-key")
  end

  config.default_cassette_options = {
    decode_compressed_response: true
  }
end
