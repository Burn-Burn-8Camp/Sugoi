class AddReferenceToStore < ActiveRecord::Migration[6.1]
  def change
    add_reference(:order_items, :store, index: true)
  end
end
