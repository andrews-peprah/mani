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
      customer = customers.order("RANDOM()").where(random_selected: false).first
    else
    	return error_msg
    end

    # If a customer is present send a success message
    if customer.present?
      # Change the customer's random selected status
      customer.random_selected = true
      customer.save!

      return success_msg(customer.reference.value)
    else
    	# Change the status of all customers
      customers.each do |customer|
      	customer.random_selected = false
      	customer.save!
      end

      # Request for random reference again
      get_random_reference(client)
    end	
  end

  # A success message
  def success_msg(ref)
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
  def error_msg
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