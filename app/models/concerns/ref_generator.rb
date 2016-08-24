module RefGenerator
  extend ActiveSupport::Concern

  included do
    after_create :generate_ref
  end

  module ClassMethods
    
  end

  # Geneate reference number for client
  # @params null
  # @return null
  def generate_ref
    new_reference = SecureRandom.base58(6)
    reference = Reference.where(value: new_reference)

    if reference.present?
      self.generate_ref
    else
      reference = Reference.new value: new_reference
      reference.customer = self
      reference.save
    end
  end
  
end