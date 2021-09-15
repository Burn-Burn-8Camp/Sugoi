class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items
	has_one_attached :picture
end
