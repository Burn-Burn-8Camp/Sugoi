class RemoveValidToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :valid, :datetime
  end
end
