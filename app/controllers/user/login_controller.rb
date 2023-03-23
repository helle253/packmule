module User
  class LoginController < ApplicationController
    def new
      @shipment_id = params.permit(:shipment_id)[:shipment_id]
    end

    def create
      token = LoginToken.create!(email: params.require(:email).downcase)
      shipment_id = params.permit(:shipment_id)[:shipment_id]
      LoginAttemptMailer.
        login_link(token.id, user_login_token_url(token, shipment_id: shipment_id)).
        deliver_now
    end
  end
end
