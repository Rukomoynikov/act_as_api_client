# frozen_string_literal: true

require "act_as_api_client"

RSpec.describe ActAsApiClient do
  it "has a version number" do
    expect(ActAsApiClient::VERSION).not_to be nil
  end

  it "doesn't add any method to general Object class" do
    expect(Object.new).not_to respond_to(:find)
  end

  it "responds to act_as_api_client class method" do
    expect(ApiClient).to respond_to(:act_as_api_client)
  end

  it "has methods from Active Record" do
    class SpotifyClient < ApiClient; end

    methods = %i[find where find_by delete create delete update]

    expect(SpotifyClient.new).to respond_to(*methods)
  end

  it "throws exception if api client file doesn't exist" do
    expect do
      class WrongClient < ApiClient
        act_as_api_client for: :wrong_client
      end
    end.to raise_error(LoadError)
  end

  it "calls method from inherited class option 'for' is provided" do
    class GithubClient < ApiClient
      act_as_api_client for: :github
    end

    expect { GithubClient.new.find }.to_not raise_error
  end

  it "doesn't affect options from another instances" do
    class GithubClient < ApiClient
      act_as_api_client for: :github, with: { token: "token1" }
    end

    class GithubClient2 < ApiClient
      act_as_api_client for: :github, with: { token: "token2" }
    end

    gh1 = GithubClient.new
    gh2 = GithubClient2.new

    expect([gh1.options[:token], gh2.options[:token]]).to eq(%w[token1 token2])
  end
end
