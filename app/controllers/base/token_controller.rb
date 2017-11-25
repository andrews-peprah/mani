class Base::TokenController < BaseController

  # creates a new token for user
  # @params client - Client model object
  # @params customer / employee - Employee model object
  def create(client,user,usertype)
    token = Token.new
    token.client = client
    token[usertype.to_sym] = user
    token = self.generate_token(token)
    token.save

    #return token to controller
    token.token
  end


  # random generator
  # @params null
  def generate_token(token) 
    # set a random token
    token.token = SecureRandom.hex(32)

    # Set time for token to expire
    # TODO: make settings dynamic
    token.expires_at = Time.now + 3600.seconds 

    return token
  end

end
