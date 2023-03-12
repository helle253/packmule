module Admin
  class RecipientController < ApplicationController
    include Admin::Authentication
    before_action :redirect_if_not_authenticated

    def index
      @recipients = Recipient.page params[:page]
    end
  end
end
