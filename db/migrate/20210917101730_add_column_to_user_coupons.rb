class AddColumnToUserCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :user_coupons, :status, :string
  end
end
