class AddColsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon_value, :integer, default: 0
    add_column :orders, :user_discount, :integer, default: 0
    add_column :orders, :delivery_fee, :integer, default: 0
  end
end
