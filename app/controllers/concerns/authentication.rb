# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_administrator
    helper_method :current_administrator
    helper_method :administrator_signed_in?
  end

  def admin_login(administrator)
    reset_session
    session[:current_administrator_email] = administrator.id
  end

  def user_login(login_token)
    session[:current_user_email] = login_token.email
    login_token.destroy!
  end

  def logout
    reset_session
    redirect_to homepage_path
  end

  def redirect_if_admin_authenticated
    return unless administrator_signed_in?

    redirect_to admin_dashboard_path, alert: 'You are already logged in.'
  end

  def redirect_if_not_admin_authenticated
    return if administrator_signed_in?

    redirect_to new_admin_sessions_path, alert: 'You need to log in, sire.'
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
