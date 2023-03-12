module User
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :current
    end

    def login(login_token)
      session[:current_user_email] = login_token.email
      login_token.destroy!
    end

    def redirect_if_authenticated
      return unless signed_in?

      redirect_to user_dashboard_path, alert: 'You are already logged in.'
    end

    def redirect_if_not_authenticated
      return if signed_in?

      redirect_to new_user_login_path, alert: 'You need to log in, milord.'
    end

    private

    def current
      Current.user ||= session[:current_user_email]
    end

    def signed_in?
      Current.user.present?
    end
  end
end
