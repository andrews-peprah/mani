require 'doorkeeper/grape/helpers'

#
# Web Api interface for web application
# @author Andrews Peprah
# @copyright SMARTKODE
#
module Web
  class V1 < Grape::API
    # Load grape helpers
    helpers Doorkeeper::Grape::Helpers

    helpers do
      private

      def current_user
        #get application id to find the clientid
        client_id = doorkeeper_token.application.owner_id

        #find merchant with merchant_id
        Client.find_by_id(client_id)
      end

    end

    #before transaction do
    before do
      doorkeeper_authorize!
    end

  end
end