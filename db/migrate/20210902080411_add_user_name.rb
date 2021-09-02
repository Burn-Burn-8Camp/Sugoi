class AddUserName < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :P_coins, :integer
  end
end
