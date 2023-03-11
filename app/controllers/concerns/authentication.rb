# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_admin
    helper_method :current_admin
    helper_method :admin_signed_in?
  end

  def login(admin)
    reset_session
    session[:current_admin_id] = admin.id
  end

  def logout
    reset_session
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: "You are already logged in." if admin_signed_in?
  end

  private

  def current_user
    Current.admin ||= session[:current_admin_id] && Admin.find_by(id: session[:current_admin_id])
  end

  def admin_signed_in?
    Current.admin.present?
  end

end
