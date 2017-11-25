class Clients::CustomersController < ClientsController

  # Show list of customers
  # @param nil
  # @return nil
  def index
    @customers = current_client.customers.order("created_at DESC")
  end

  def show
    
  end

  def toggle
    customer = current_client.customers.find(params[:id])
    if customer.present?
      customer.is_verified = not(customer.is_verified)
      customer.activation_count += 1
      if customer.save
          if customer.activation_count == 1
            # Build the hierarchy
            Mani::HierarchyBuilder.rebuild(customer)

            # Calculate the amount parent needs to get
            Mani::ThirdParty::Floxchange.recalculate_parent_amount(customer)
          end
        flash[:notice] = "Customer state successfully changed"
      else
        flash[:alert] = "Error while changing customer's state. Please try again later."
      end
    end
    redirect_back(fallback_location: clients_customers_url)
  end
end
