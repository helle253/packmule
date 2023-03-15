module User
  class AllergiesController < ApplicationController
    include User::Authentication

    before_action :redirect_if_not_authenticated

    def edit
      @recipient = Current.recipient
      @allergens = Allergen.all
      @selected =  @recipient.allergens
    end

    def update
      Current.recipient.update!(params.require(:recipient).permit(allergen_ids: []))
      redirect_back(fallback_location: homepage_path, notice: 'Profile updated')
    end
  end
end
