class Administrator < ApplicationRecord
  include BCrypt

  has_secure_password

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def login
    @administrator = Administrator.find_by(email: params[:email])
    if @administrator.password == params[:password]
      give_token
    else
      redirect_to home_url
    end
  end
end
