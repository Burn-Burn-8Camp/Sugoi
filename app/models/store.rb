class Store < ApplicationRecord
  has_many :products
  has_many :store_orders
  has_many :orders, through: :store_orders
  has_many :order_items
  has_many :seller_comments
  belongs_to :user

  validates :name, presence: true, uniqueness: true
end
