# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_administrator
    helper_method :current_administrator
    helper_method :administrator_signed_in?
  end

  def login(administrator)
    reset_session
    session[:current_administrator_id] = administrator.id
  end

  def logout
    reset_session
  end

  def redirect_if_authenticated
    redirect_to new_admin_session_path, alert: "You are already logged in." if administrator_signed_in?
  end

  private

  def current_administrator
    Current.administrator ||= session[:current_administrator_id] &&
                              Administrator.find_by(id: session[:current_administrator_id])
  end

  def administrator_signed_in?
    Current.administrator.present?
  end
end
