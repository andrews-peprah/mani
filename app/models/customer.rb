class Customer < ApplicationRecord
  has_secure_password

  belongs_to  :client
  has_many    :tokens
  has_one	  :reference, dependent: :destroy
  
  # Self referential for hierarchy
  has_one :parent
  has_one :parent, :through => :parent

  include PinEncrypter
  include RefGenerator
end
