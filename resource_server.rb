require_relative "./authorisation_server.rb"

class ResourceServer
  INVALID_ACCESS_TOKEN_MESSAGE = "Error: Resource could not be accessed because the access token was invalid"

  def initialize(resource)
    @resource = resource
    @authorisation_server = AuthorisationServer.new
  end

  def protected_resource(access_token:)
    if authorisation_server.valid_access_token? access_token
      resource
    else
      INVALID_ACCESS_TOKEN_MESSAGE
    end
  end

  private

  attr_reader :resource, :authorisation_server
end
