#
# mPowerPayments Gh
# ==================================================================================================
# MPower is a new payment service that works with your preferred digital wallet
# or bank account to offer a convenient, safer and overall better payment experience.
# It is a complete end-to-end online and mobile payment transactions solution to enable
# consumers and businesses send, spend and receive payments.
#
# New technologies are putting our lives, our communities, and our world at the tips
# of our fingers; mobile money, debit/credit card, internet banking, bank electronic transfers, etc.
#
# With MPower, we're using those same ideas to build a new payment experience that's powered by you.
#
# MPower is built and managed by a group of developers and entrepreneurs
# passionate about using mobile and web technology to drive social change.
#

module Mani
  module ThirdParty
    module Mpowerpayment

      # receive payment from the customer
      # telephone (mobile money)
      #
      # curl sample
      # ================================================================
      # curl -H "Content-Type: application/json" \
      # -H "MP-Master-Key: dd6f2c90-f075-012f-5b69-00155d866600" \
      # -H "MP-Private-Key: live_private_amOI11Gb0SIo6NSLZr1xkfOYSuE" \
      # -H "MP-Token: d25e1f4ddc053779d526" \
      # -X POST -d '{ "customer_name" : "Alfred Robert Rowe", "customer_phone" : "0244124661", "customer_email" : "customer@domainname.com", "wallet_provider" : "MTN", "merchant_name" : "Classic Shoes Ltd", "amount" : "10" }' \
      # "https://app.mpowerpayments.com/api/v1/direct-mobile/charge"
      def receive_payment(customer,amount,live)
        wallet_provider = Mani::Provider.get(customer.telephone)

        request_body = {
                        customer_phone: customer.telephone,
                        customer_name: customer.fullname,
                        wallet_provider: wallet_provider,
                        merchant_name: "Oboafo",
                        amount: amount
                        }

        # TODO: move keys to environment variables
        if live
          response = HTTP.headers(
                        accept: "application/json",
                        "MP-Master-Key": "5e468b95-fd9a-420b-a858-e39a339e392d",
                        "MP-Private-Key": "live_private_zIUzdj8EzktFGtRYuxg9Vr4NiJo",
                        "MP-Token": "86fa1acfcab82eea0783"
                        )
              .post("https://app.mpowerpayments.com/api/v1/direct-mobile/charge",
                    :json => request_body)
        else
          response = HTTP.headers(
                        accept: "application/json",
                        "MP-Master-Key": "5e468b95-fd9a-420b-a858-e39a339e392d",
                        "MP-Private-Key": "test_private_fQPYMxSyrhV8j8aDigZzNRR4gUM",
                        "MP-Token": "85d936d79310c65094a5"
                        )
              .post("https://app.mpowerpayments.com/api/v1/direct-mobile/charge",
                    :json => request_body)
        end

        # Update customer's account with payment token
        response = JSON.parse(response)
        response = response.symbolize_keys

        if response[:response_code] == "00"
          customer.pay_token = response[:token]
          customer.save
          return {
                    success: true,
                    response: {
                      type: "payment_requested",
                      message: "Payment has been requested."
                    }
                  }
        else
          return {
                    success: false,
                    response: {
                      type: "error_request",
                      message: "There was an error requesting for payment"
                    }
                  }
        end

      end


      # Send money to the customer
      # telephone (mobile money)
      def send_payment(customer)

      end


      # Check status of payment
      #
      # curl -H "Content-Type: application/json" \
      # -H "MP-Master-Key: dd6f2c90-f075-012f-5b69-00155d866600" \
      # -H "MP-Private-Key: live_private_amOI11Gb0SIo6NSLZr1xkfOYSuE" \
      # -H "MP-Token: d25e1f4ddc053779d526" \
      # -X POST -d '{ "token" : "6d875bf6f28b4c5d01e58e7c"}' \
      # "https://app.mpowerpayments.com/api/v1/direct-mobile/status"
      def check_status(customer,live)
        wallet_provider = Mani::Provider.get(customer.telephone)

        request_body = { token: customer.pay_token }

        # TODO: move keys to environment variables
        if live
          response = HTTP.headers(
                        accept: "application/json",
                        "MP-Master-Key": "5e468b95-fd9a-420b-a858-e39a339e392d",
                        "MP-Private-Key": "live_private_zIUzdj8EzktFGtRYuxg9Vr4NiJo",
                        "MP-Token": "86fa1acfcab82eea0783"
                        )
              .post("https://app.mpowerpayments.com/api/v1/direct-mobile/status",
                    :json => request_body)
        else
          response = HTTP.headers(
                        accept: "application/json",
                        "MP-Master-Key": "5e468b95-fd9a-420b-a858-e39a339e392d",
                        "MP-Private-Key": "test_private_fQPYMxSyrhV8j8aDigZzNRR4gUM",
                        "MP-Token": "85d936d79310c65094a5"
                        )
              .post("https://app.mpowerpayments.com/api/v1/direct-mobile/status",
                    :json => request_body)
        end

        # Update customer's account with payment token
        response = JSON.parse(response)
        response = response.symbolize_keys

        # Check response code and type of response
        if response[:response_code] == "00"
          case response[:tx_status]
          when "complete"
            customer.is_verified = true
            customer.save

            # Form message
            message = {
                      title: "Oboafo",
                      small_msg: "You have successfully paid into Oboafo",
                      big_msg: "You have been successfully verified as an Oboafo member. Get ready for super greatness!!"
                      }

            # Send a notification to the user
            Mani::GcmNotifier.notify( customer,
                                      message,
                                      "paid")

            recalculate_parent_amount(customer)

            result = {
                      success: true,
                      response: {
                        type: "money_paid",
                        message: "You have successfully paid.",
                        paid: true
                      }
                    }
          when "cancelled"
            # Form message
            message = {
                      title: "Oboafo",
                      small_msg: "Payment has been cancelled",
                      big_msg: "You cancelled the payment. We are expecting you very soon."
                      }

            # Send a notification to the user
            Mani::GcmNotifier.notify( customer,
                                      message,
                                      "cancelled")

            result = {
                      success: false,
                      response: {
                        type: "payment_cancelled",
                        message: "Payment has been cancelled.",
                        paid: false
                      }
                    }
          when "pending"
            result = {
                      success: true,
                      response: {
                        type: "payment_pending",
                        message: "Payment is still pending.",
                        paid: false
                      }
                    }
          end
        else
          result = {
                    success: false,
                    response: {
                      type: "error_request",
                      message: "Please try again",
                      paid: false
                    }
                  }
        end

        # Send the user a notification

        # Send this result out
        return result
      end

      def recalculate_parent_amount(customer)
        parent_reference = customer.reference.parent_reference

        if parent_reference.present?
          reference = Reference.find_by(value: parent_reference)
          if reference.present?
            # Get customer
            customer = reference.customer

            # Calculate the amount in the current level
            customer.calculate_funds

            # Notify parent
            message = {
              is_money: false,
              message: "You are on you way to greatness. Another member has just been added to your hierarchy. Hurray!!",
              title: "Another member has been added to your hierarchy. Hurray!!!"
            }

            Mani::GcmNotifier.notify(customer,message,"member_added")
          end
        end
      end

      module_function :receive_payment, :send_payment, :check_status, :recalculate_parent_amount
    end
  end
end
