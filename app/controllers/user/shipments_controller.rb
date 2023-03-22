module User
  class ShipmentsController < ApplicationController
    include User::Authentication

    def index
      register_for_shipment
    end

    def create
      register_for_shipment
    end

    def register_for_shipment
      if signed_in?
        RecipientShipment.find_or_create_by(
          recipient: Current.recipient,
          shipment_id: params.require(:shipment_id),
        )
        redirect_to homepage_path, notice: 'Signed up for Shipment'
      else
        redirect_to new_user_login_path(redirect_url: request.original_url)
      end
    end
  end
end
