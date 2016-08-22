require 'doorkeeper/grape/helpers'

#
# Mobile api interface for android application
# Android application would be given to customers
# @author Andrews Peprah
# @copyright SMARTKODE
#
module Mobile
  class V1 < Grape::API
    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end
    
    helpers do
      private

      def current_user
        #get application id to find the client_id
        client_id = doorkeeper_token.application.owner_id
        
        client = Client.find(client_id)
      end
    end

    # Login resource for authentication
    # @params from the client specs
    resource :customer_login do
      desc "Uses the customer username and password to login"

      params do
        requires :username, type: String, desc: "Username of customer"
        requires :password, type: String, desc: "Password of customer"
      end

      post do
        # Log user in
        # Mobile Login's are always
        customer_controller = Customer::LoginController.new

        # Create hash and send parameters
        data   = {
          username: params[:username],
          password: params[:password],
          client:   current_user
        }

        result = customer_controller.create(data)
        return result 
      end
    end

    # Profile resource 
    resource :me do
      desc "Returns details of client"
      
      get do
        puts "hellow world"
      end
    end
  end
end