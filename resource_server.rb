require_relative "./authorisation_server.rb"

class ResourceServer
  INVALID_ACCESS_TOKEN_MESSAGE = "Error: Resource could not be accessed because the access token was invalid"

  def initialize(resource:, authorisation_server:)
    @resource = resource
    @authorisation_server = authorisation_server
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


__END__

require_relative './resource_server.rb'
require_relative './authorisation_server.rb'

authorisation_server = AuthorisationServer.new
grant = authorisation_server.authorise
token = authorisation_server.authenticate(grant)

resource_server  = ResourceServer.new(resource: "Secrets", authorisation_server: authorisation_server)

resource_server.protected_resource(access_token: token)
