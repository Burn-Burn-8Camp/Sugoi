class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :price
      t.string :quantity
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
