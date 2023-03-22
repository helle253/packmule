module User
  class LoginTokenController < ApplicationController
    def show
      token = LoginToken.find_by(id: params[:id])
      if token
        login(token)
        redirect_url = params.permit(:redirect_url)[:redirect_url]
        redirect_to redirect_url || edit_user_my_allergies_path, notice: 'Logged in.'
      else
        redirect_to homepage_path, notice: 'That token is no longer valid.'
      end
    end
  end
end
