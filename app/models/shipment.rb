class Shipment < ApplicationRecord
  has_one_attached :image

  validates :image, presence: true

  def in_future?
    fulfillment_date.present? && fulfillment_date > Time.zone.today
  end
end
