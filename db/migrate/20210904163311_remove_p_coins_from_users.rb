class RemovePCoinsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :P_coins, :integer
  end
end
