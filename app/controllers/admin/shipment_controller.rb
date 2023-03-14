module Admin
  class ShipmentController < ApplicationController
    include Admin::Authentication
    before_action :redirect_if_not_authenticated

    def index
      @shipments = Shipment.page params[:page]
    end

    def new
    end

    def edit
    end

    def create
      Shipment.create!(params.permit(:title, :image))
      redirect_to admin_shipment_index_path, notice: 'Created new item'
    end

    def update
    end

    def destroy
    end
  end
end
