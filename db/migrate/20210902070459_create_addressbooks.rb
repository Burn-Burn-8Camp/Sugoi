class CreateAddressbooks < ActiveRecord::Migration[6.1]
  def change
    create_table :addressbooks do |t|
      t.string :receiver
      t.string :tel
      t.string :address
      t.string :area_code
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
