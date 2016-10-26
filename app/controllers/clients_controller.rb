class ClientsController < ApplicationController
  before_action :authenticate_client!
  before_action :get_client

  def index
    @customers = @client.customers.count
  end

  def get_client
    if current_client.present?
      @client = Client.find_by(id: current_client["id"])
    end
  end

  def show
  end
end
