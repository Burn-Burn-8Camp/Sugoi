class CreateUserCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :user_coupons do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :coupon, null: false, foreign_key: true

      t.timestamps
    end
    remove_reference(:coupons, :user, index: true)
  end
end
