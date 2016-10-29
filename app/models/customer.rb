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

  validates_uniqueness_of :telephone, :message => "Telephone has already been taken"
  validates_uniqueness_of :email, :message => "Email has already been taken"
  
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

  # Gets the parent record
  def parent
    if self.reference.present?
      parent_reference = Reference.find_by(value: self.reference.parent_reference)
      if parent_reference.present?
        Customer.find_by(id: parent_reference.customer_id)
      end
    end
  end

  # Set the parent value
  def parent=(parent_customer)
    reference_value = parent_customer.reference.value

    if self.reference.present?
      r = self.reference
      r.parent_reference = reference_value
      r.save
    end
  end

  # Verified children
  def verified_children
    self.children.where(is_verified: true)
  end
end
