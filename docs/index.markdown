---
layout: home
image: "./assets/thumbnail.jpg"
---

![Act as api logo](/assets/thumbnail.jpg)

## Supported clients:

- [Anthropic](clients/anthropic)

## Example of usage:

Any API client can be used with or withour Rails. All what you need to do is
inherit from ApiClient and choose service through `act_as_api_client for:`. Also
some clients may require some settings token etc.

**Add to Gemfile:**
{% highlight ruby %}
gem 'act_as_api_client'
{% endhighlight %}

**Request service:**
{% highlight ruby %}
require "act_as_api_client"

class AnthropicClient < ApiClient
  act_as_api_client for: %i[anthropic messages],
                    with: { x_api_key: ENV["ANTHROPIC_API_KEY"] }
end

anthropic_client = AnthropicClient.new

anthropic_client.create(
  model: "claude-3-5-sonnet-20241022",
  messages: [{ "role": "user", "content": "Hello there." }],
  max_tokens: 1024
)
{% endhighlight %}
