class Shipment < ApplicationRecord
  has_one_attached :image

  scope :orderable, lambda {
    where.not(fulfillment_date: nil).
      where('? < fulfillment_date', Time.zone.today + 2)
  }

  def in_future?
    fulfillment_date.present? && fulfillment_date > Time.zone.today
  end
end
