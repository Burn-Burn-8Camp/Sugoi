class AddProductSubtotalCplToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :product_subtotal, :integer
  end
end
