class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.text :describtion
      t.string :category
      t.string :material
      t.string :manufacturing_method
      t.string :country
      t.text :content

      t.timestamps
    end
  end
end
