module Admin
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :current
    end

    def login(administrator)
      reset_session
      session[:current_administrator_id] = administrator.id
    end

    def redirect_if_authenticated
      return unless signed_in?

      redirect_to admin_dashboard_path, alert: 'You are already logged in.'
    end

    def redirect_if_not_authenticated
      return if signed_in?

      redirect_to new_admin_session_path, alert: 'You need to log in, sire.'
    end

    private

    def current
      Current.administrator ||= session[:current_administrator_id] &&
                                Administrator.find_by(id: session[:current_administrator_id])
    end

    def signed_in?
      Current.administrator.present?
    end
  end
end
