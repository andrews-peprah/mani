module AccountGeneratable
  extend ActiveSupport::Concern

  included do
    after_create :generate_account
  end

  module ClassMethods
    
  end

  # Geneate doorkeeper application for client
  # @params null
  # @return null
  def generate_account
    # Use doorkeeper to generate application
    acc = Account.new
    acc.customer = self
    acc.save
  end
end