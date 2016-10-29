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
        customer_controller = Customers::LoginController.new

        # Create hash and send parameters
        data = {
          username: params[:username],
          password: params[:password],
          client: current_user
        }

        result = customer_controller.create(data)
        return result
      end
    end

    # Grant user access
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
    # @returns hash
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
        #Check for uniqueness of some fields
        uniquefield = Customers::UniqueFieldController.new
        result = uniquefield.index(current_user,params)

        if result[:success]
          customer = CustomerController.new
          result = customer.create(current_user,params)
        end


        return result
      end

    end


    # Resource for device registration
    # @params gcmId
    # @returns hash
    resource :register_device do
      desc "Stores device's gcm id into the database"

      params do
        requires :id, type: String, desc: "Id of customer"
        requires :gcm_id, type: String, desc: "GCM id of device"
      end

      post do
        gcm_controller = Customers::GcmController.new
        result = gcm_controller.create(current_user,params)
        return result
      end
    end


    # Payment Endpoints
    # POST: Creates a new payment
    # GET:  References a payment for status
    #
    resource :payment do
      desc "Make a payment request to mPowerPayment"

      params do
        requires :id, type: String, desc: "Id of customer"
      end

      post do
        customers = current_user.customers
        customer = customers.where(id: params[:id])
        puts "#{current_user.to_json}"
        if customer.present?
          customer = customer.first
          ThirdParty::PaymentWorker.perform_async(params[:id])
          return { success: true,
                   response: {
                       type: "request_sent",
                       message: "Request sent to MM wallet. Please check your phone."
                    }
                 }
        else
          { success: false,
             response: {
                 type: "customer_absent",
                 message: "Customer not found in db."
              }
           }
        end
      end

      desc "Get payment status from FloXchange"

      params do
        requires :id, type: String, desc: "Id of customer"
      end

      get do
        customers = current_user.customers
        customer = customers.where(id: params[:id])
        if customer.present?
          customer = customer.last

          reference,access_token = customer.pay_token.split("|***|")
          
          #return Mani::ThirdParty::Mpowerpayment.check_status(customer,true)
          return Mani::ThirdParty::Floxchange.check_status(customer,true,access_token,reference)
        else
          { success: false,
             response: {
                 type: "customer_absent",
                 message: "Customer not found in db."
              }
           }
        end
      end
    end

    # Profile Endpoint
    # POST: Update profile ~ Change pin
    # GET:  Retrieves profile
    resource :profile do
      desc "Get the profile information"

      params do
        requires :id, type: String, desc: "Id of customer"
      end

      get do
        customer_profile = Customers::ProfileController.new
        profile = customer_profile.index(current_user,params)
        return profile
      end

    end
  end
end
