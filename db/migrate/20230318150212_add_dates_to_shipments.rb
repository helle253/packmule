class AddDatesToShipments < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :fulfillment_date, :date
  end
end
