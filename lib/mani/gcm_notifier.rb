module Mani
  module GcmNotifier
    # TODO: Put into a worker
    # Sends notification to customer
    def notify(customer,message=nil,type=nil)
      # Setup gcm
      gcm = GCM.new("AIzaSyC2IQPxDIiBvtNewRZkDgHAJqqGy7AXiLU")

      # Get the registration id
      registration_ids = [customer.registered_device.gcm_id]

      options = {data: message, collapse_key: type}

      gcm.send(registration_ids, options)

    end

    module_function :notify
  end
end