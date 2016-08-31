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
      
      # Notify parent
      message = {
        is_money: false,
        message: "You are on you way to greatness. Another member has just been added to your hierarchy. Hurray!!",
        title: "Another member has been added to your hierarchy. Hurray!!!"
      }

      Mani::GcmNotifier.notify(parent_customer,message,"member_added")

      # Save hierarchy
      if hierarchy.save
        success_msg
      else
        error_msg
      end

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