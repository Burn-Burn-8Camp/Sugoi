class ChangeAccumulatedAmountToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :accumulated_amount, 0)
    change_column_default(:users, :p_coins, 0)
  end
end
