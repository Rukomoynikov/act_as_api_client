# frozen_string_literal: true

RSpec.describe ActAsApiClient do
  context "with general methods" do
    it "doesn't add any method to general Object class" do
      expect(Object.new).not_to respond_to(:find)
    end
  end

  context "with act_as_api_client class method" do
    let(:wrong_client_class) do
      Class.new(ApiClient) do
        act_as_api_client for: :wrong_client
      end
    end

    it "responds to act_as_api_client" do
      expect(ApiClient).to respond_to(:act_as_api_client)
    end

    it "throws exception if api client file doesn't exist" do
      expect do
        wrong_client_class
      end.to raise_error(ActAsApiClient::Errors::NonExistingClient)
    end
  end
end
