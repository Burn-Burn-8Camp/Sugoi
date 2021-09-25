class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.float :value
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
