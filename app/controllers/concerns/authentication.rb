# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  def logout
    reset_session
    redirect_to homepage_path, notice: 'Logged Out.'
  end
end
