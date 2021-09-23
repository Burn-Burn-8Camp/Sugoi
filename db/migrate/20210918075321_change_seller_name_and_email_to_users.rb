class ChangeSellerNameAndEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :seller_name, "")
    change_column_default(:users, :seller_email, '')
    change_column_null(:users, :seller_email, false)
    change_column_null(:users, :seller_name, false)
  end
end
