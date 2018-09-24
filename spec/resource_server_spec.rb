require "spec_helper"
require "byebug"
require_relative "../resource_server.rb"

describe ResourceServer do
  let(:resource_server) { ResourceServer.new resource: resource, authorisation_server: AuthorisationServer.new }
  let(:resource) { "Juicy/sensitive data" }

  describe "#protected_resource" do
    let(:invalid_access_token) { "invalid access token" }
    let(:valid_access_token) do
      authorisation_server = resource_server.send :authorisation_server
      grant = authorisation_server.authorise
      token = authorisation_server.authenticate(grant)
    end

    it "is the resource" do
      expect(resource_server.protected_resource(access_token: valid_access_token)).to eq resource
    end

    it "is an error message if the access token is invalid" do
      response = resource_server.protected_resource(access_token: invalid_access_token)
      expect(response).to eq described_class::INVALID_ACCESS_TOKEN_MESSAGE
    end
  end
end
