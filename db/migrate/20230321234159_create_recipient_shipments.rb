class CreateRecipientShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :recipient_shipments do |t|
      t.integer :recipient_id, null: false
      t.integer :shipment_id, null: false
      t.timestamps
    end
  end
end
