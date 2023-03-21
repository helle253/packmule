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
      allergen_ids = params.
                       require(:recipient).
                       require(:allergens).
                       to_unsafe_h.
                       map { |k, v| v == 'true' ? k : nil }.
                       compact
      Current.recipient.update!(allergen_ids: allergen_ids)
      redirect_back(fallback_location: homepage_path, notice: 'Profile updated')
    end
  end
end
