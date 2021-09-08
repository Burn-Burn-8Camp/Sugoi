class CreateStoreOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :store_orders do |t|
      t.belongs_to :store, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps

      remove_reference(:orders, :store, index: true)
    end


  end
end
