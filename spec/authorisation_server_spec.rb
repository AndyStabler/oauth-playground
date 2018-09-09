require "spec_helper"
require_relative "../authorisation_server.rb"

describe AuthorisationServer do
  let(:authorisation_server) { AuthorisationServer.new }

  let(:grant) { authorisation_server.authorise }
  let(:access_token) { authorisation_server.authenticate grant }

  describe "#authorise" do
    it "is a valid grant" do
      expect(grant).to be_a String
      expect(authorisation_server.send :valid_grants).to include grant
    end
  end

  describe "#authenticate" do
    let(:valid_tokens) { authorisation_server.send :valid_tokens }

    it "swaps an authorisation grant with an access token" do
      expect(access_token).to be_a String
      expect(valid_tokens).to include access_token
    end

    it "is an error if the grant is invalid" do
      invalid_authentication = authorisation_server.authenticate "invalid grant"
      expect(invalid_authentication).to eq described_class::INVALID_GRANT_MESSAGE
    end
  end

  describe "#valid_access_token?" do
    let(:valid_access_token) { access_token }
    let(:invalid_access_token) { "invalid access token" }
    it "is true when the access token is valid" do
      expect(authorisation_server.valid_access_token? valid_access_token).to be true
    end

    it "is false when the access token is invalid" do
      expect(authorisation_server.valid_access_token? invalid_access_token).to be false
    end
  end
end
