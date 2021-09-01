class AddOrderTotal < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :accumulated_amount, :integer
  end
end
