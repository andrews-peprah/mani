class Clients::CustomersController < ClientsController

  # Show list of customers
  # @param nil
  # @return nil
  def index
    @customers = current_client.customers
  end

  def show
    
  end
end
