class AddPCoinsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :p_coins, :integer
  end
end
