class Customer::LoginController < CustomerController

  # Creates a new login for customer
  # @params login parameters
  def create(data = nil)
    # Fetch client login parameters based on login
    # Information presented

    # If client is available get all customers
    customers = data[:client].customers

    # If there are no customers return an error message
    unless customers.present?
      return {
        success: false,
        response: {
          type: "no_customers",
          message: "Client doesn't have any registered customer"
        }
      }
    end

    #If there are customers search for customer
    customer = customers.where(username: data[:username]).first

    #If the customer is not present send an error message
    unless customer.present?
      return {
        success: false,
        response: {
          type: "customer_unavailable",
          message: "Customer username is not available"
        }
      }
    end

    #if the user is present authenticate the user
    if customer.authenticate(data[:password])
      return {
        success: true,
        response: {
          type: "successful_login",
          message: "You have successfully logged in",
          customer: {
                      id:         customer.id,
                      first_name: customer.first_name,
                      last_name:  customer.last_name,
                      username:   customer.username,
                      telephone:  customer.telephone,
                      reference:  customer.reference.value,
                      is_verified: customer.is_verified,
                      level:      customer.level,
                      people:     customer.children.where(is_verified: true).size
                    }
        }
      }
    else
      # Send an incorrect password message
      return {
        success: false,
        response: {
          type: "incorrect_password",
          message: "Wrong customer password"
        }
      }
    end
  end

end
