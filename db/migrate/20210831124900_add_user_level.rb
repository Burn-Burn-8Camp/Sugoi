class AddUserLevel < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rank, :string
    add_index  :users, :rank
  end
end
