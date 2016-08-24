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
    # @return nil
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
    # @params nil
    # @return nil
    resource :me do
      desc "Returns details of client"
      
      get do
        return 
          { success: true,
            response: {
              type: "access_granted",
              message: "You have an unexpired token"
                  }
              }
      end
    end

    # Return a random customer's reference for 
    # customer's easy registration
    # @params nil
    # @return nil
    resource :random_reference do
      desc "Returns random reference number"

      get do 
        customer = CustomerController.new
        result = customer.get_random_reference(current_user)
        puts result
        return result
      end

    end


    # Resource for customer
    # @params nil
    # @reurns hash
    resource :customers do
      desc "Creates a new user"

      params do
        requires :first_name, type: String, desc: "First name of customer"
        requires :last_name,  type: String, desc: "Last name of customer"
        requires :username,   type: String, desc: "Username of customer"
        requires :telephone,  type: String, desc: "Telephone/ msisdn of customer"
        requires :password,   type: String, desc: "Password of customer"
        requires :reference,  type: String, desc: "Parent's reference"
      end

      post do
        puts params
        
        uniquefield = Customer::UniqueFieldController.new
        result = uniquefield.index(current_user,params)
        
        if result[:success]
          customer = CustomerController.new
          result = customer.create(current_user,params)
        end


        return result
      end

    end



  end
end
