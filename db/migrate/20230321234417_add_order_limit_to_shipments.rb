class AddOrderLimitToShipments < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :order_limit, :integer, default: 6
  end
end
