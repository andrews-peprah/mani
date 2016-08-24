class CustomerController < BaseController
  include ReferenceGenerator

  def create(client=nil,params=nil)
  	customer = Customer.new(first_name: params[:first_name],
  							last_name:  params[:last_name],
  							username:   params[:username],
  							telephone:  params[:telephone],
  							password:   params[:password],
  							pin_code:    "1234")
  	
  	customer.client = client

  	if customer.save
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


end
