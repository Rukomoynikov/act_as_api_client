# frozen_string_literal: true

RSpec.describe ActAsApiClient::BaseApiMethods do
  context "when basic class" do
    let(:spotify_client_class) do
      Class.new(ApiClient)
    end

    it "has methods from Active Record" do
      methods = %i[find where find_by delete create delete update]

      expect(spotify_client_class.new).to respond_to(*methods)
    end
  end
end
