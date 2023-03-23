module User
  class ShipmentsController < ApplicationController
    include User::Authentication

    def create
      register_for_shipment
    end

    def register_for_shipment
      shipment_id = params.require(:shipment_id)
      if signed_in?
        RecipientShipment.find_or_create_by(
          shipment_id: shipment_id,
          recipient: Current.recipient,
        )
        redirect_to homepage_path, notice: "Signed up for #{Shipment.find(shipment_id).title}"
      else
        redirect_to new_user_login_path(shipment_id: shipment_id)
      end
    end
  end
end
