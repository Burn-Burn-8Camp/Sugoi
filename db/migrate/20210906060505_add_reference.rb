class AddReference < ActiveRecord::Migration[6.1]
  def change
    add_reference(:products, :store, index: true)
    add_reference(:orders, :store, index: true)
  end
end
