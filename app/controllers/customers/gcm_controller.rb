class Customer::GcmController < CustomerController

  # Registers a new device on the system
  # GOOGLE CLOUD MESSENGER
  def create(client = nil,params = nil)
    puts params
    customers = client.customers

    if customers.present?
      customer = customers.where(id: params[:id])

      if customer.present?
        customer = customer.first

        # Create a new RegisteredDevice model object
        registered_device = RegisteredDevice.new 
        registered_device.gcm_id = params[:gcm_id]

        # save registered device
        if registered_device.save
          # Assign device to customer
          customer.registered_device = registered_device

          if customer.save
            return {
              success: true,
              response: {
                type: "device_registered",
                message: "Device has been registered on GCM"
              }
            }
          end
        end
      end
    end

    return {
      success: false,
      response: {
        type: "gcm_registration_error",
        message: "Error registering device on GCM"
      }
    }
    
  end

end
