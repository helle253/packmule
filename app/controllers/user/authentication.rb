module User
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :current
    end

    def login(token)
      recipient = Recipient.find_or_create_by!(email: token.email)
      session[:current_recipient_id] = recipient.id
      token.destroy!
      recipient
    end

    def redirect_if_authenticated
      return unless signed_in?

      redirect_to user_dashboard_path, alert: 'You are already logged in.'
    end

    def redirect_if_not_authenticated
      return if signed_in?

      redirect_to new_user_login_path, alert: 'You need to log in, milord.'
    end

    def signed_in?
      Current.recipient.present?
    end

    private

    def current
      Current.recipient ||= session[:current_recipient_id] &&
                            Recipient.find_by(id: session[:current_recipient_id])
    end
  end
end
