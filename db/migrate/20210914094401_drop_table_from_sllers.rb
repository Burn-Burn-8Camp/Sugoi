class DropTableFromSllers < ActiveRecord::Migration[6.1]
  def change
    drop_table :sellers
  end
end
