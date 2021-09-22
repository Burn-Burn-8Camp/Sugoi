class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items
	has_one_attached :picture
	enum delivery: {"貨運 NT$100": 100}
end
