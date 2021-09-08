class Change < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :describtion
    add_column :products, :description, :string
  end
end
