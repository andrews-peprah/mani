class Customer < ApplicationRecord
  has_secure_password

  belongs_to  :client
  has_many    :tokens

  include PinEncrypter

end
