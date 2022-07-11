# frozen_string_literal: true

RSpec.describe ActAsApiClient::Clients::HttpClient do
  let(:github_client_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :github, with: { token: "token1" }
    end
  end

  context "when GithubClient" do
    it "responds to all http methods" do
      methods = %i[get put delete post update]

      methods.each do |method_name|
        expect(
          github_client_class.new.method(method_name.to_sym)
        ).to be_a_kind_of(Method)
      end
    end
  end

  it "calls method from inherited class option 'for' is provided", :vcr do
    expect { github_client_class.new.find("Rukomoynikov/tabled") }.not_to raise_error
  end
end
