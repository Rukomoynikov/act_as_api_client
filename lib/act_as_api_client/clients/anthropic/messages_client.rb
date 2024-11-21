# frozen_string_literal: true

require_relative "../http_client"

# See the documentation on https://docs.anthropic.com/en/api/messages

module ActAsApiClient
  module Clients
    module Anthropic
      module MessagesClient
        ANTHROPIC_VERSION = "2023-06-01"
        BASE_URL = "https://api.anthropic.com/v1/messages"

        include HttpClient

        def create(**params)
          post(BASE_URL, headers: headers, body: body(**params))
        end

        private

        def headers
          default = {
            "Content-Type": "application/json",
            "x-api-key" => options[:x_api_key],
            "anthropic-version" => options[:anthropic_version] || ANTHROPIC_VERSION
          }

          default["anthropic-beta"] = options[:anthropic_beta] if options[:anthropic_beta]

          default
        end

        # rubocop:disable Metrics/ParameterLists, Metrics/CyclomaticComplexity, Metrics/MethodLength
        def body(model:,
                 messages:,
                 max_tokens:,
                 metadata: nil,
                 stop_sequences: nil,
                 stream: false,
                 system: nil,
                 temperature: 1.0,
                 tool_choice: nil,
                 tools: nil,
                 top_k: nil,
                 top_p: nil)
          default = {
            model: model,
            messages: messages,
            max_tokens: max_tokens,
            stream: stream,
            temperature: temperature
          }

          default[:metadata] = metadata if metadata
          default[:stop_sequences] = stop_sequences if stop_sequences
          default[:system] = system if system
          default[:tool_choice] = tool_choice if tool_choice
          default[:tools] = tools if tools
          default[:top_k] = top_k if top_k
          default[:top_p] = top_p if top_p

          default
        end
        # rubocop:enable Metrics/ParameterLists, Metrics/CyclomaticComplexity, Metrics/MethodLength
      end
    end
  end
end
