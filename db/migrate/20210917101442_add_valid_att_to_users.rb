class AddValidAttToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :valid_at, :datetime
  end
end
