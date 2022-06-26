# frozen_string_literal: true

require 'act_as_api_client'

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

    methods = [:find, :where, :find_by, :delete, :create, :delete, :update]

    expect(SpotifyClient.new).to respond_to(*methods)
  end
end
