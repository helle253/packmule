class CreateRecipientAllergens < ActiveRecord::Migration[7.0]
  def change
    create_table :recipient_allergens do |t|
      t.integer :recipient_id, null: false
      t.integer :allergen_id, null: false
      t.timestamps
    end
  end
end
