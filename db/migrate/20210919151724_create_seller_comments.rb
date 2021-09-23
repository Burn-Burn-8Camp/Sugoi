class CreateSellerComments < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_comments do |t|
      t.belongs_to :store, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true
      t.integer :rate
      t.text :content

      t.timestamps
    end
  end
end
