class Administrator < ApplicationRecord
  include BCrypt

  has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
