class Customer::ProfileController < ClientController

  def index(client=nil, params=nil)

    begin
      customer = client.customers.where(id: params[:id])

      if customer.present?
        customer = customer.first

        # Get the customer's accounts
        accounts = customer.accounts
        amount = 0

        if accounts.present?
          amount = accounts.first.fund.to_f #TODO: Refactor
        end

        {
          success: true,
          response: {
            type: "profile_retrieved",
            message: "Customer profile retrieved",
            customer: {
                  id:         customer.id,
                  first_name: customer.first_name,
                  last_name:  customer.last_name,
                  username:   customer.username,
                  telephone:  customer.telephone,
                  reference:  customer.reference.value,
                  is_verified: customer.is_verified,
                  level:      customer.level,
                  people:     customer.children.where(is_verified: true).size,
                  amount:     amount
                }
          }
        }
      else
        {
          success: false,
          response: {
            type: "customer_absent",
            message: "Profile details are not present"
          }
        }
      end

    rescue Exception => e
      {
          success: false,
          response: {
            type: "system_error",
            message: "Please try again later",
            exception: e
          }
        }
    end
  end
end
