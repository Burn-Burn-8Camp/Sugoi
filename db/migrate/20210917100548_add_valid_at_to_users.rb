class AddValidAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :valid, :datetime
  end
end
