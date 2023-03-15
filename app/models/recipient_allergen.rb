class RecipientAllergen < ApplicationRecord
  belongs_to :recipient
  belongs_to :allergen
end
