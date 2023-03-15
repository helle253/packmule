class Allergen < ApplicationRecord
  has_many :recipient_allergens, dependent: :destroy
  has_many :recipients, through: :recipient_allergens
end
