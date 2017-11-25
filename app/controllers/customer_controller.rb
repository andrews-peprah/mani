class CustomerController < BaseController
  include ReferenceGenerator
  include HierarchyBuilder

  def create(client=nil,params=nil)
  	customer = Customer.new(first_name: params[:first_name],
  							last_name:  params[:last_name],
  							username:   params[:username],
  							telephone:  params[:telephone],
  							password:   params[:password],
  							pin_code:    "1234")
  	
    # Set customer to client
  	customer.client = client

  	if customer.save

      # Build customer hierarchy
      build_hierarchy(customer,params)
      
  		return {
  			success: true,
  			response: {
  						type: "customer_created",
  						message: "Customer successfully created"
  					}
  				}
  	else
  		return {
  			success: false,
  			response: {
  						type: "error_creating",
  						message: "Error creating customer"
  					}
  				}
  	end

  end

  #
  # Shows user details
  #
  def show
    
  end


end
