module Admin
  class ShipmentController < Admin::BaseController
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
      Shipment.create!(params.permit(%i[title description image]))
      redirect_to admin_shipment_index_path, notice: 'Created new item'
    end

    def update
      Shipment.
        find_by(id: params[:id]).
        update(params.require(:shipment).permit(:title, :description, :image))
      redirect_to admin_shipment_index_path, notice: 'Updated item'
    end

    def destroy
      Shipment.find_by(id: params[:id]).destroy!
      redirect_to admin_shipment_index_path, notice: 'Deleted item'
    end
  end
end
