class Shipment < ApplicationRecord
  has_one_attached :image

  has_many :recipient_shipments, dependent: :destroy
  has_many :recipients, through: :recipient_shipments

  validates :order_limit, numericality: { less_than: 100 }

  def self.orderable
    Shipment.
      where('? < fulfillment_date AND fulfillment_date IS NOT NULL', Time.zone.today + 2).
      select { |s| s.recipient_shipments.count < s.order_limit }
  end

  def image_content?
    image.content_type&.starts_with?('image/')
  end

  def video_content?
    image.content_type&.starts_with?('video/')
  end
end
