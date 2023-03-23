module User
  class LoginTokenController < ApplicationController
    def show
      token = LoginToken.find_by(id: params[:id])
      go_to_homepage unless token

      recipient = login(token)
      shipment_id = params.permit(:shipment_id)[:shipment_id]

      return register_for_shipment_and_redirect(shipment_id, recipient) if shipment_id

      redirect_to edit_user_my_allergies_path, notice: 'Logged In'
    end

    def register_for_shipment_and_redirect(shipment_id, recipient)
      RecipientShipment.find_or_create_by!(
        recipient: recipient,
        shipment_id: shipment_id,
      )
      redirect_to edit_user_my_allergies_path,
                  notice: "Signed up for the #{Shipment.find(shipment_id).title}"
    end

    def go_to_homepage
      redirect_to homepage_path, notice: 'That token is no longer valid.'
    end

    def no_shipment_redirect
    end
  end
end
