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

        # Sends request to Anthropic API https://docs.anthropic.com/en/api/messages
        #
        # @param model [String] The model that will complete your prompt
        # @param messages [Array] Input messages
        # @param max_tokens [Integer] The maximum number of tokens to generate before stopping
        # @param metadata [Hash] An object describing metadata about the request
        # @param stop_sequences [Array<String>] Custom text sequences that will cause the model to stop generating
        # @param stream [Boolean] Whether to incrementally stream the response using server-sent events
        # @param system [String] System prompt
        # @param temperature [Float] Amount of randomness injected into the response
        # @param tool_choice [Hash] How the model should use the provided tools
        # @param tools [Array<Hash>] Definitions of tools that the model may use
        # @param top_k [Integer] Only sample from the top K options for each subsequent token
        # @param top_p [Float] Use nucleus sampling
        #
        # @return [Hash] Response from Anthropic API
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
