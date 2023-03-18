module User
  class LoginController < ApplicationController
    include User::Authentication
    def new
    end

    def create
      token = LoginToken.create!(email: params.require(:email).downcase)
      LoginAttemptMailer.login_link(token.id, user_login_token_url(token)).deliver_now
    end
  end
end
