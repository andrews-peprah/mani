# Cashin worker queues request and performs them asynchronously
class ThirdParty::PaymentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(customer_id)
    customer = Customer.find_by(id: customer_id)
    amount = 30 #amount to be charged GHS30.00
    Mani::ThirdParty::Floxchange.receive_payment(customer,amount,true)
  end
end