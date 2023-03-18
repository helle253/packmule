class HomepageController < ApplicationController
  def show
    @current_administrator = Administrator.find_by(id: session[:current_administrator_id])
    @current_recipient = Recipient.find_by(id: session[:current_recipient_id])
  end
end
