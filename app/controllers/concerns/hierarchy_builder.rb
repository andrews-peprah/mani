module HierarchyBuilder
	extend ActiveSupport::Concern
  
  included do  
  end

  # This builds the builds the relationship
  # between the reference owner and the 
  # new customer
  def build_hierarchy(customer,params)
    # If reference parameter is sent
  	if params[:reference].present?
      # Find parent's reference
      parent_reference = Reference.where(value: params[:reference])

      # Find the parent customer
      parent_customer = parent_reference.first.customer

      # Associate child customer to parent
      hierarchy = parent_customer.parentship.build(:child_id => customer.id)

      # Save hierarchy
      if hierarchy.save
        # Set paren hierarchy in customer's details
        customer_reference = customer.reference
        customer_reference.parent_reference = params[:reference]
        if customer_reference.save
          return success_msg
        end
      end
      
      error_msg
    end

  end



  # A success message
  def success_msg
  	{
      success: true,
      response: {
        type: "hierarchy_built",
        message: "Customer successfully associated"
      }
    }
  end

  # An error message
  def error_msg
  	{
      success: false,
      response: {
        type: "hierarchy_error",
        message: "Error associating customer"
      }
    }
  end

end