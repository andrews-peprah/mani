#
# FloXchange Gh
# ==================================================================================================
# FloXchange is the newest payment platform which gives the client an ability to terminate money
# Clients are able to retrieve money from customers and share it among any other customer
# they wish to send to
# FloXchange supports cashIn/cashOut and airtime
#

module Mani
  module ThirdParty
    module Floxchange

      # Gets access token
      # from floxchange server
      def get_access_token
        # Get the access_key
        # {
        #   "client_id": "provide_client_id",
        #   "client_secret": "provide_client_secret",
        #   "grant_type": "client_credentials"
        #  }

        request_body = {
                        "client_id": "13a3369bc69b11c9ef0a422688c68f971f4c30971f918bd9cb012e4496350167",
                        "client_secret": "dae563e93cbc52ab6af03934cffb56f5b5227f46ed09e424a9471d050d3d0f64",
                        "grant_type": "client_credentials"
                        }

          response = HTTP
              .post("https://api.floxchange.com/api/v1/login.json",
                    :json => request_body)


      end
      # receive payment from the customer
      # telephone (mobile money)
      #
      # curl sample
      # ==================================================
      #
      def receive_payment(customer,amount,live=false)
        response = get_access_token

        # Update customer's account with payment token
        response = JSON.parse(response)
        response = response.symbolize_keys

        if response[:access_token]
          access_token = response[:access_token]
          # Request was successful
          response = send_payment(customer,
                                  amount,access_token)
          response = JSON.parse(response)
          response = response.symbolize_keys

          if response[:success]
            if customer.update_attribute(:pay_token,"#{response[:response]["reference"]}|***|#{access_token}")
                 {success: true,
                  response: {
                      type: "request_sent",
                      message: "Request sent to MM wallet"
                    }
                 }
            end
          else
             {success: false,
              response: {
                 type: "wrong_params",
                 message: "Please check your telephone number. Make sure it is MTN, Airtel or Tigo"
              }
             }
          end
        else
          return {
              success: false,
              response: {
                type: "request_failed",
                message: "Something went wrong"
              }
            }
        end
      end


      # Send money to the customer
      # telephone (mobile money)
      def send_payment(customer,amount,access_token)

        request_body = {
                "amount": amount,
                "currency": "Ghs",
                "customer_no": customer.telephone,
                "customer_name": customer.fullname,
                "country_code": "GH",
                "service_code": "cashout",
                "live": true,
                "dummy": false
        }

          response = HTTP
              .post("https://api.floxchange.com/api/v1/receive.json?access_token=#{access_token}",
                    :json => request_body)

      end



      # Check status of payment
      #
      # curl -H "Content-Type: application/json" \
      # -H "MP-Master-Key: dd6f2c90-f075-012f-5b69-00155d866600" \
      # -H "MP-Private-Key: live_private_amOI11Gb0SIo6NSLZr1xkfOYSuE" \
      # -H "MP-Token: d25e1f4ddc053779d526" \
      # -X POST -d '{ "token" : "6d875bf6f28b4c5d01e58e7c"}' \
      # "https://app.mpowerpayments.com/api/v1/direct-mobile/status"
      def check_status(customer,live,access_token,reference)

        # TODO: move keys to environment variables
        response = HTTP
            .get("https://api.floxchange.com/api/v1/transactions.json?ref=#{reference}&access_token=#{access_token}")

        puts response

        # Update customer's account with payment token
        response = JSON.parse(response)
        response = response.symbolize_keys

        # Check response code and type of response
        if response[:success]
          case response[:transaction][0]["status"]
          when "Paid"
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
          when "Failed"
            # Form message
            message = {
                      title: "Oboafo",
                      small_msg: "Payment was unsuccessful.",
                      big_msg: "Payment wasn't successful. Please check your mobile money wallet."
                      }

            # Send a notification to the user
            Mani::GcmNotifier.notify( customer,
                                      message,
                                      "cancelled")

            result = {
                      success: false,
                      response: {
                        type: "payment_cancelled",
                        message: "Payment wasn't successful. Please check your mobile money wallet and try again.",
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

      module_function :receive_payment, :send_payment, :check_status, :recalculate_parent_amount, :get_access_token
    end
  end
end
