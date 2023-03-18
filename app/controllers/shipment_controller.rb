class ShipmentController < ApplicationController
  include User::Authentication

  def index
    @shipments = Shipment.all
  end
end
