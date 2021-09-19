class AddStoreOrdersCol < ActiveRecord::Migration[6.1]
  def change
    add_column :store_orders, :shipment_confirm, :boolean, default: false
  end
end
