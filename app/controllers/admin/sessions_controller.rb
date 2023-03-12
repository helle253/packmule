module Admin
  class SessionsController < ApplicationController
    before_action :redirect_if_admin_authenticated, only: %i[create new]

    def new
    end

    def create
      @administrator = Administrator.find_by(email: params[:administrator][:email].downcase)
      if @administrator&.authenticate(params[:administrator][:password])
        admin_login @administrator
        redirect_to admin_dashboard_path, notice: 'Logged in.'
      else
        flash_wrong_password
      end
    end

    def flash_wrong_password
      redirect_to new_admin_session_path, flash: { alert: 'Incorrect email or password.' }
    end
  end
end
