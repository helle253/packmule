module User
  class LoginTokenController < ApplicationController
    def show
      token = LoginToken.find(params[:id])
      user_login(token)
      redirect_to homepage_path, notice: 'Logged in.'
    end
  end
end
