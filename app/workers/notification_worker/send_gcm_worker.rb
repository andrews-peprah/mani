class NotificationWorker::SendGcmWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  # Calls mbackoffice to get agents
  def perform(data)
    data = data.symbolize_keys
    registration_ids = data[:registration_ids]
    options = data[:options]

    # Setup gcm
    gcm = GCM.new("AIzaSyC2IQPxDIiBvtNewRZkDgHAJqqGy7AXiLU")

    gcm.send(registration_ids, options)
  end

end