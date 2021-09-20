class Coupon < ApplicationRecord
  has_many :users, through: :user_coupons
  has_many :user_coupons

end
