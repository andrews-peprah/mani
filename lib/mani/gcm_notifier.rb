module Mani
  module GcmNotifier
    # TODO: Put into a worker
    # Sends notification to customer
    def notify(customer,message=nil,type=nil)
      # get registered device
      if customer.registered_device.present?
        # Get the registration id
        registration_ids = [customer.registered_device.gcm_id]

        options = {data: message, collapse_key: type}

        data = {registration_ids: registration_ids,
                options: options}

        ThirdParty::SendGcm.perform_async(data)
      end
    end

    module_function :notify
  end
end