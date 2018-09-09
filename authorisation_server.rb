require 'SecureRandom'

class AuthorisationServer

  INVALID_GRANT_MESSAGE = "Error: Invalid grant"

  def initialize
    @valid_tokens = []
    @valid_grants = []
  end

  def authorise
    # user authorises
    grant = generate_grant
    valid_grants << grant
    grant
  end

  def authenticate(grant)
    # check grant is correct
    # authenticate the client
    if valid_grant? grant
      invalidate_grant(grant)
      token = generate_access_token
      valid_tokens << token
      token
    else
      INVALID_GRANT_MESSAGE
    end
  end

  def valid_access_token?(token)
    valid_tokens.include? token
  end

  private
  attr_accessor :valid_grants, :valid_tokens

  def generate_grant
    SecureRandom.uuid
  end

  def valid_grant?(grant)
    valid_grants.include? grant
  end

  def invalidate_grant(grant)
    valid_grants.delete grant
    nil
  end

  def generate_access_token
    SecureRandom.uuid
  end
end

__END__

require_relative './authorisation_server.rb'
authorisation_server  = AuthorisationServer.new
authorisation_server.valid_access_token? "123456"

grant = authorisation_server.authorise
token = authorisation_server.authenticate("2345")
token = authorisation_server.authenticate(grant)
