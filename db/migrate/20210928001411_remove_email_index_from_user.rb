class RemoveEmailIndexFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :email, unique: true
    add_index :users, :account, unique: true
  end
end
