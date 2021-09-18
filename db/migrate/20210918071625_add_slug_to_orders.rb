class AddSlugToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :slug, :string
    add_index :orders, :slug, unique: true
    remove_column :orders, :friendly_id, :string
  end
end
