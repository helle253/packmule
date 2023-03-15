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
      email, notes = params.require(:recipient).require(%i[email notes])

      @recipient.update!(email: email.downcase, notes: notes)
      redirect_back(fallback_location: homepage_path, notice: 'User Updated')
    end

    def destroy
      Recipient.find(params[:id]).destroy!
      redirect_back(fallback_location: homepage_path, notice: 'User Deleted')
    end
  end
end
