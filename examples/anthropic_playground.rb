# frozen_string_literal: true

# Run it with `ruby anthropic_playground.rb`
# See Anthropic development API documentation on https://docs.anthropic.com/en/api/messages

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  gem "act_as_api_client", path: "../"
end

require "act_as_api_client"

class AnthropicClient < ApiClient
  act_as_api_client for: %i[anthropic messages],
                    with: { x_api_key: ENV["ANTHROPIC_API_KEY"] }
end

anthropic_client = AnthropicClient.new

pp anthropic_client.create(
  model: "claude-3-5-sonnet-20241022",
  messages: [
    { "role": "user", "content": "Hello there." },
    { "role": "assistant", "content": "Hi, I'm Claude. How can I help you?" },
    { "role": "user", "content": "Can you explain LLMs in plain English?" }
  ],
  max_tokens: 1024
)
