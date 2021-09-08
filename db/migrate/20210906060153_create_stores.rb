class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
