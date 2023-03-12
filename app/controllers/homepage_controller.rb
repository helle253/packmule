class HomepageController < ApplicationController
  def show
    @current_administrator = Administrator.find_by(session[:current_administrator_id])
    @current_user = session[:current_user_email]
  end
end
