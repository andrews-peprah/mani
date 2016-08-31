class Customer < ApplicationRecord
  has_secure_password

  belongs_to  :client
  has_many    :tokens
  has_one	    :reference, dependent: :destroy
  has_one     :registered_device, dependent: :destroy
  
  # Self referential for hierarchy
  has_many :parentship
  has_many :children, :through => :parentship

  include PinEncrypter
  include RefGenerator
  include LevelCalculatorable
  
  # sends fullname
  def fullname
    "#{self.first_name} #{self.last_name}"
  end
end
