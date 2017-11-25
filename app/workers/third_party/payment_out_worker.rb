# Cashin worker queues request and performs them asynchronously
class ThirdParty::PaymentOutWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(customer_id)
    customer = Customer.find_by(id: customer_id)
    amount = customer.accounts.last.fund.to_i
    Mani::ThirdParty::Floxchange.send_payment(customer,amount,true)
  end
end