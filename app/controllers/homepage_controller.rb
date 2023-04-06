class HomepageController < ApplicationController
  def show
    @upcoming_shipments = Shipment.upcoming.sort_by(&:fulfillment_date).first(4)
  end
end
