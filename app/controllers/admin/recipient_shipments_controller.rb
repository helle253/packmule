module Admin
  class RecipientShipmentsController < ApplicationController
    def destroy
      sr = RecipientShipment.find(params.require(:id))
      s = sr.shipment
      if RecipientShipment.find(params.require(:id)).destroy
        redirect_to edit_admin_shipment_path(s), notice: 'Destroyed'
      else
        redirect_back(fallback_location: homepage_path, notice: "Couldn't destroy")
      end
    end
  end
end
