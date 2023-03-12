module User
  class LoginController < ApplicationController
    def new
    end

    def create
      token = LoginToken.create!(email: params[:email].downcase)
      LoginAttemptMailer.login_link(token.id, homepage_url).deliver_now
    end
  end
end
