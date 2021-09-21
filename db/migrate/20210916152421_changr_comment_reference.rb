class ChangrCommentReference < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:comments, :product, index: true)
    add_reference(:comments, :order_item, index: true)
    drop_table :addressbooks
    drop_table :deliveries
    remove_column :products, :country
    remove_column :products, :manufacturing_method
    remove_column :products, :material
  end
end
