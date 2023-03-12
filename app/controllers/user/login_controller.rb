module User
  class LoginController < ApplicationController
    def new
    end

    def create
      LoginToken.create!(email: params[:email].downcase)
    end
  end
end
