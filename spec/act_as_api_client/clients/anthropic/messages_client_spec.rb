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

    context "when params are valid" do
      it "sends request" do
        response = api_client.new.create(model: "claude-3-5-sonnet-20241022",
                                         messages: [{ "role": "user", "content": "Hello, world" }],
                                         max_tokens: 1024)

        expect(response["content"][0]["text"]).to eq("Hi! How can I help you today?")
      end
    end

    context "when params are invalid" do
      it "sends request" do
        response = api_client.new.create(model: "",
                                         messages: [{ "role": "user", "content": "Hello, world" }],
                                         max_tokens: 1024)

        expect(response["type"]).to eq("error")
      end
    end

    # rubocop:disable Layout/LineLength, RSpec/ExampleLength
    context "when request/response is streamed" do
      it "receives response in chunks" do
        chunks = []
        api_client.new.create(model: "claude-3-5-sonnet-20241022",
                              messages: [{ "role": "user", "content": "Hello, world" }],
                              max_tokens: 1024,
                              stream: true) do |response|
          chunks << response
        end

        expect(chunks).to eq([
                               { "type" => "message_start", "message" => { "id" => "msg_01LTUZ9njPqg8kNK7qAGDFKy", "type" => "message", "role" => "assistant", "model" => "claude-3-5-sonnet-20241022", "content" => [], "stop_reason" => nil, "stop_sequence" => nil, "usage" => { "input_tokens" => 10, "output_tokens" => 1 } } },
                               { "type" => "content_block_start", "index" => 0, "content_block" => { "type" => "text", "text" => "" } },
                               { "type" => "ping" },
                               { "type" => "content_block_delta", "index" => 0, "delta" => { "type" => "text_delta", "text" => "Hi" } },
                               { "type" => "content_block_delta", "index" => 0, "delta" => { "type" => "text_delta", "text" => "! Nice to meet you. How can I help you today" } },
                               { "type" => "content_block_delta", "index" => 0, "delta" => { "type" => "text_delta", "text" => "?" } },
                               { "type" => "content_block_stop", "index" => 0 },
                               { "type" => "message_delta", "delta" => { "stop_reason" => "end_turn", "stop_sequence" => nil }, "usage" => { "output_tokens" => 17 } },
                               { "type" => "message_stop" }
                             ])
      end
    end
    # rubocop:enable Layout/LineLength, RSpec/ExampleLength
  end
end
