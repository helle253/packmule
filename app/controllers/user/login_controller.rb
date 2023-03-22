module User
  class LoginController < ApplicationController
    def new
      @redirect_url = params.permit(:redirect_url)[:redirect_url]
    end

    def create
      token = LoginToken.create!(email: params.require(:email).downcase)
      redirect_url = params.permit(:redirect_url)[:redirect_url]
      LoginAttemptMailer.
        login_link(token.id, user_login_token_url(token, redirect_url: redirect_url)).
        deliver_now
    end
  end
end
