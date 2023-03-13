module Admin
  class RecipientController < ApplicationController
    include Admin::Authentication
    before_action :redirect_if_not_authenticated

    def index
      @recipients = Recipient.page params[:page]
    end

    def edit
      @recipient = Recipient.find(params[:id])
    end

    def update
      @recipient = Recipient.find(params[:id])

      @recipient.email = params[:recipient][:email].downcase
      @recipient.notes = params[:recipient][:notes]
      @recipient.save!
      redirect_back(fallback_location: homepage_path, notice: 'User Updated')
    end
  end
end
