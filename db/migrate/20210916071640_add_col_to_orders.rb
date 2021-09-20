class AddColToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon_name, :string, :default => "未使用"
  end
end