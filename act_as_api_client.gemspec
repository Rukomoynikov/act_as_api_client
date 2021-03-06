# frozen_string_literal: true

require_relative "lib/act_as_api_client/version"

Gem::Specification.new do |spec|
  spec.name          = "act_as_api_client"
  spec.version       = ActAsApiClient::VERSION
  spec.authors       = ["Max Rukomoynikov"]
  spec.email         = ["rukomoynikov@gmail.com"]

  spec.summary       = "Collection of predefined API clients"
  spec.description   = "Helps you to build reliable API clients in a minute. Just add act_as_api_client to your classes"
  spec.homepage      = "https://rubygems.org/gems/act_as_api_client"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata = {
    "source_code_uri" => "https://github.com/Rukomoynikov/act_as_api_client",
    "homepage_uri" => spec.homepage,
    "documentation_uri" => "https://rubydoc.info/github/Rukomoynikov/act_as_api_client/main",
    "bug_tracker_uri" => "https://github.com/Rukomoynikov/act_as_api_client/issues"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
