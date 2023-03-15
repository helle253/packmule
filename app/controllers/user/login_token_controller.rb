module User
  class LoginTokenController < ApplicationController
    include User::Authentication

    def show
      token = LoginToken.find_by(id: params[:id])
      if token
        login(token)
        redirect_to edit_user_my_allergies_path, notice: 'Logged in. Let us know what you cant eat so we dont kill you on accident!'
      else
        redirect_to homepage_path, notice: 'That token is no longer valid.'
      end
    end
  end
end
