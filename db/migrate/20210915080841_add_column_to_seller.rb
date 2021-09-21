class AddColumnToSeller < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :seller_email, :string
    add_column :users, :seller_name, :string
  end
end
