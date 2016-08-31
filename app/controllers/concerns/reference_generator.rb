module ReferenceGenerator
	extend ActiveSupport::Concern

  included do
   
  end

  # Logic for getting random reference
  def get_random_reference(client)
  	# Check the size of customers
    customers = client.customers

    # If customers are more than one
    # Choose the customer who has not been selected
    # before at random
    if customers.size > 0
      customer = customers.order("RANDOM()").where(random_selected: false, is_verified: true).first
    else
    	return ref_error_msg
    end

    # If a customer is present send a success message
    if customer.present?

      # Check customer's hierarchy size
      # If they exceed the limit search for another person
      if customer.children.size > 363
        get_random_reference(client)
      end

      # Change the customer's random selected status
      customer.random_selected = true
      customer.save!

      return ref_success_msg(customer.reference.value)
    else
      verified_present = false

    	# Change the status of all customers
      customers.each do |customer|
        verified_present = customer.is_verified
      	customer.random_selected = false
      	customer.save!
      end

      if verified_present
        # Request for random reference again
        get_random_reference(client)
      else
        ref_error_msg
      end
    end	
  end

  # A success message
  def ref_success_msg(ref)
  	{
      success: true,
      response: {
        type: "reference_retrieved",
        message: "Reference retrieved",
        reference: ref
      }
    }
  end

  # An error message
  def ref_error_msg
  	{
      success: false,
      "response": {
        type: "no_reference",
        message: "No reference available",
        reference: ""
      }
    }
  end

end