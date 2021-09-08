class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :shipping_method

      t.timestamps
    end
  end
end
