# frozen_string_literal: true

require "act_as_api_client/clients/anthropic/messages_client"
require "act_as_api_client/errors/non_existing_client_error"

RSpec.describe ActAsApiClient::Clients::Anthropic::MessagesClient do
  describe "use client that doesn't exist" do
    let(:api_client) do
      Class.new(ApiClient) do
        act_as_api_client for: :invalid_client
      end
    end

    it "raises a valid error" do # rubocop:disable RSpec/ExampleLength
      expect do
        api_client.new
      end.to raise_error(
        ActAsApiClient::Errors::NonExistingClient,
        "The requested client (invalid_client) doesn't exist"
      )
    end
  end

  describe "sending message", vcr: true do
    let(:api_client) do
      Class.new(ApiClient) do
        act_as_api_client for: %i[anthropic messages],
                          with: { x_api_key: YAML.load_file("spec/credentials.yml").dig("anthropic", "messages", "x-api-key") } # rubocop:disable Layout/LineLength
      end
    end

    it "sends request" do
      api_client.new.create(model: "claude-3-5-sonnet-20241022",
                            messages: [{ "role": "user", "content": "Hello, world" }],
                            max_tokens: 1024)
    end
  end
end
