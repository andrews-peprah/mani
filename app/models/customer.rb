class Customer < ApplicationRecord
  has_secure_password

  belongs_to  :client
  has_many    :tokens
  has_one	    :reference, dependent: :destroy
  has_one     :registered_device, dependent: :destroy

  # Self referential for hierarchy
  has_many :parentship
  has_many :children, :through => :parentship
  has_many :accounts,  dependent: :destroy

  include PinEncrypter
  include RefGenerator
  include LevelCalculatorable
  include AccountGeneratable

  # sends fullname
  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  # Calculates the funds for current hierarchy level
  def calculate_funds
    # If customer has an account
    if accounts.present?
      account = accounts.first
      account.fund = "#{account.fund.to_f + calculate_amount(self.children.where(is_verified: true).size)}"
      account.save
    else
      # If customer doesn't have account
      acc = Account.new
      acc.customer = self
      acc.save

      calculate_funds
    end
  end
end
