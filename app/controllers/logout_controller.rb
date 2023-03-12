class LogoutController < ApplicationController
  def show
    logout
    redirect_to homepage_path, notice: 'Logged Out.'
  end
end
