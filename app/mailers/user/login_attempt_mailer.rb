module User
  class LoginAttemptMailer < ApplicationMailer
    def login_link(token_id, url)
      @url = url
      @token = LoginToken.find(token_id)
      mail(to: @token.email)
    end
  end
end
