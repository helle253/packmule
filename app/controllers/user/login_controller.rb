module User
  class LoginController < ApplicationController
    def new
    end

    def create
      token = LoginToken.create!(email: params[:email].downcase)
      LoginAttemptMailer.login_link(token.id, user_login_token_url(token)).deliver_now
    end
  end
end
