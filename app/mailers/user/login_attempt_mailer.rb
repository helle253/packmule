module User
  class LoginAttemptMailer < ApplicationMailer
    default from: 'noreply@packmule.com'

    def login_link(token_id, url)
      @url = url
      @token = LoginToken.find(token_id)
      if @token.expired?
        @token.destroy!
      else
        ## TODO
        # @url = user_login_tokens_path(@token)
        mail(to: @token.email)
      end
    end
  end
end
