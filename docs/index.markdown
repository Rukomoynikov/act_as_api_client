---
layout: home
---

Collection of API clients tried and tested.

## Supported clients:

- [Anthropic](clients/anthropic)

## Example of usage:

Any API client can be used with or withour Rails. All what you need to do is
inherit from ApiClient and choose service through `act_as_api_client for:`. Also
some clients may require some settings token etc.

{% highlight ruby %}
require "act_as_api_client"

class AnthropicClient < ApiClient
  act_as_api_client for: %i[anthropic messages],
                    with: { x_api_key: ENV["ANTHROPIC_API_KEY"] }
end

anthropic_client = AnthropicClient.new
{% endhighlight %}
