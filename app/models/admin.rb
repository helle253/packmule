class Admin < ApplicationRecord
  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def login
    @user = Admin.find_by(email: params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to home_url
    end
  end
end
