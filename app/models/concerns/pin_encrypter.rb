module PinEncrypter
  extend ActiveSupport::Concern

  included do
    before_create :encrypt_pin
  end

  module ClassMethods
    
  end

  # Encrypts pin_code
  # @params null
  # @return null
  def encrypt_pin
    self.pin_code = Digest::SHA256.hexdigest(self.pin_code)
  end
end