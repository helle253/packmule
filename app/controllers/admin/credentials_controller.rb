module Admin
  class CredentialsController < Admin::BaseController
    def edit
      @administrator = Current.administrator
    end

    def update
      update_params = params.require(:administrator).
                        permit(:email, :password, :password_confirmation)
      if Current.administrator.update(update_params)
        redirect_back(fallback_location: homepage_path, notice: 'Credentials updated')
      else
        redirect_back(fallback_location: homepage_path, notice: 'Update failed!')
      end
    end
  end
end
