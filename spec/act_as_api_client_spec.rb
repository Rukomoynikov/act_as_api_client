# frozen_string_literal: true

require "act_as_api_client"

RSpec.describe ActAsApiClient do
  it "has a version number" do
    expect(ActAsApiClient::VERSION).not_to be nil
  end

  it "responds to act_as_api_client class method" do
    SpotifyClient = Class.new do
      act_as_api_client
    end

    expect(SpotifyClient).to respond_to(:act_as_api_client)
  end

  it "has methods from Active Record" do
    SpotifyClient = Class.new do
      act_as_api_client
    end

    methods = %i[find where find_by delete create delete update]

    expect(SpotifyClient.new).to respond_to(*methods)
  end

  it "throws exception if api client file doesn't exist" do
    expect {
      Class.new do
        act_as_api_client for: :villian_client
      end
    }.to raise_error(ActAsApiClient::ClientFileExistingError)
  end

  # it "calls method from inherited class option 'for' is provided" do
  #   GithubClient = Class.new do
  #     act_as_api_client for: :github
  #   end
  #
  #   expect(GithubClient.new.find).to_not raise(StandardError, "Should be defined in inherited class")
  # end
end
