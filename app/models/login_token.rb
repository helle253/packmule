class LoginToken < ApplicationRecord
  ##
  # Scope for all stale confirmation tokens
  #
  scope :expired, -> { where('? < ?', Time.now.utc, created_at + ttl) }

  ##
  # Cleanup method for cleaning out expired tokens.
  #
  def self.destroy_expired!
    expired.each(&:destroy!)
  end

  def expired?
    Time.now.utc > created_at + ttl
  end
end
