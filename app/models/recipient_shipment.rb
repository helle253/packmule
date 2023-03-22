class RecipientShipment < ApplicationRecord
  belongs_to :recipient
  belongs_to :shipment
end
