module User
  class LoginTokenController < ApplicationController
    include User::Authentication

    def show
      token = LoginToken.find_by(id: params[:id])
      if token
        login(token)
        redirect_to homepage_path, notice: 'Logged in.'
      else
        redirect_to homepage_path, notice: 'That token is no longer valid.'
      end
    end
  end
end
