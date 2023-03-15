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
      @shipment = Shipment.
                    find_by(id: params[:id])
    end

    def create
      Shipment.create!(params.permit(%i[title image]))
      redirect_to admin_shipment_index_path, notice: 'Created new item'
    end

    def update
      Shipment.
        find_by(id: params[:id]).
        update(params[:shipment].permit(:title, :image))
      redirect_to admin_shipment_index_path, notice: 'Updated item'
    end

    def destroy
      Shipment.find_by(id: params[:id]).destroy!
      redirect_to admin_shipment_index_path, notice: 'Deleted item'
    end
  end
end
