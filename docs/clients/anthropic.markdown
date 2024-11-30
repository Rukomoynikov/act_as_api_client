---
layout: post
---

The Messages API lets you send messages with text or images, and receive a response from the AI model. You can use it in two main ways:

**Simple sync request:**
{% highlight ruby %}
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
{% endhighlight %}

**Async (stream) request:**
{% highlight ruby %}
anthropic_client.create(
  model: "claude-3-5-sonnet-20241022",
  messages: [
    { "role": "user", "content": "Hello there." },
    { "role": "assistant", "content": "Hi, I'm Claude. How can I help you?" },
    { "role": "user", "content": "Can you explain LLMs in plain English?" }
  ],
  max_tokens: 1024,
  stream: true
) do |event, data|
  p event
  p data
end
{% endhighlight %}

**Response:**
{% highlight ruby %}
{"id"=>"msg_017gdUbYuH8Y51y5TngCNbnN",
 "type"=>"message",
 "role"=>"assistant",
 "model"=>"claude-3-5-sonnet-20241022",
 "content"=>
  [{"type"=>"text",
    "text"=>
     "Sure! Let me explain Large Language Models (LLMs) in simple terms:\n" +
     "\n" +
     "LLMs are computer programs that have been trained on massive amounts of text from the internet, books, and other sources. Think of them like incredibly well-read students who have absorbed information from millions of documents.\n" +
     "\n" +
     "These models learn patterns in language - how words fit together, how sentences are structured, and how ideas connect. They can then use these patterns to:\n" +
     "- Generate human-like text\n" +
     "- Answer questions\n" +
     "- Summarize information \n" +
     "- Translate languages\n" +
     "- Help with writing\n" +
     "- And much more\n" +
     "\n" +
     "I'm an LLM myself. When you write something to me, I look at the patterns I learned during training to understand what you're saying and formulate relevant responses. However, I don't actually \"understand\" things the way humans do - I work by recognizing and generating patterns in text.\n" +
     "\n" +
     "The \"Large\" in LLM refers to both the massive amount of training data used and the number of parameters (connection points) in the model - often billions or trillions.\n" +
     "\n" +
     "Think of it like a very sophisticated autocomplete system, but one that can maintain context and generate much longer, more coherent responses.\n" +
     "\n" +
     "Would you like me to elaborate on any part of this explanation?"}],
 "stop_reason"=>"end_turn",
 "stop_sequence"=>nil,
 "usage"=>{"input_tokens"=>38, "output_tokens"=>272}}
{% endhighlight %}

**Supported options:**
- `model (string)` - [LLM model](https://docs.anthropic.com/en/docs/about-claude/models) to process your request
- `messages (list)` - list of messages (see example above)
- `max_tokens (number)` - the maximum number of tokens to generate before stopping
- `metadata (hash)` - an object describing metadata about the request
- `stop_sequences (list)` - custom text sequences that will cause the model to stop generating
- `stream (boolean)` - whether to incrementally stream the response using server-sent events
- `system (string)` - system prompt
- `temperature (float)` - system prompt
- `tool_choice (hash)` - how the model should use the provided tools
- `tools (list)` - definitions of tools that the model may use
- `top_k (number)` - only sample from the top K options for each subsequent token
- `top_p (float)` - use nucleus sampling
