class HomepageController < ApplicationController
  def show
    @orderable_shipments = Shipment.orderable.sort_by(&:fulfillment_date).first(4)
  end
end
