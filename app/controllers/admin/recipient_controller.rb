module Admin
  class RecipientController < Admin::BaseController
    def index
      @recipients = Recipient.page params[:page]
    end

    def edit
      @recipient = Recipient.find(params[:id])
    end

    def update
      @recipient = Recipient.find(params[:id])
      email, notes, allergen_ids = params.require(:recipient).require(%i[email notes allergen_ids])

      @recipient.update!(email: email.downcase, notes: notes, allergen_ids: allergen_ids)
      redirect_back(fallback_location: homepage_path, notice: 'User Updated')
    end

    def destroy
      Recipient.find(params[:id]).destroy!
      redirect_back(fallback_location: homepage_path, notice: 'User Deleted')
    end
  end
end
