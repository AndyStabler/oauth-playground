require_relative "./authorisation_server.rb"

class ResourceServer
  INVALID_ACCESS_TOKEN_MESSAGE = "Error: Resource could not be accessed because the access token was invalid"

  # The resource server is used for controlling access to some resource(s)
  # We're delegating authorisation logic to the AuthorisationServer
  def initialize(resource:, authorisation_server:)
    @resource = resource
    @authorisation_server = authorisation_server
  end

  # If a user has authorised the application, they should have received
  # an authorisation grant.
  # The application they're using should have then swapped this grant for
  # an access token using the authorisatio server.
  #
  # Using this access token, a user can access a protectef resource
  # If the access token is invalid (it's expired for example), then the
  # user is prevented from accessing the juicy secrets
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
