class Employee < ApplicationRecord
  has_secure_password

  belongs_to  :client
  has_many    :tokens
end
