class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :serial
      t.string :receiver
      t.string :tel
      t.string :address
      t.string :email
      t.string :delivery
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
