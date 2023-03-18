module Admin
  class AllergensController < Admin::BaseController
    before_action :redirect_if_not_authenticated
    layout 'admin'

    def index
      @allergens = Allergen.page params[:page]
    end

    def new
    end

    def edit
      @allergen = Allergen.find(params.require(:id))
    end

    def create
      if Allergen.create(params.permit(:title))
        redirect_to admin_allergens_path, notice: 'Created'
      else
        redirect_back(fallback_location: homepage_path, notice: 'Create Failed')
      end
    end

    def update
      update_params = params.require(:allergen).permit(:title)
      if Allergen.find(params.require(:id)).update(update_params)
        redirect_to admin_allergens_path, notice: 'Updated'
      else
        redirect_back(fallback_location: homepage_path, notice: 'Update failed')
      end
    end

    def destroy
      if Allergen.find(params.require(:id)).destroy
        redirect_to admin_allergens_path, notice: 'Destroyed'
      else
        redirect_back(fallback_location: homepage_path, notice: "Couldn't destroy")
      end
    end
  end
end
