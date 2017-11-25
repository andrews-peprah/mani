# Cashin worker queues request and performs them asynchronously
class Client::LoginWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
end