class AddColMessageToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :message, :text
  end
end
