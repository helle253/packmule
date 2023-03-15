class Recipient < ApplicationRecord
  has_many :recipient_allergens, dependent: :destroy
  has_many :allergens, through: :recipient_allergens
end
