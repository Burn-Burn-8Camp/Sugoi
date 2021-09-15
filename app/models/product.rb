class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items
	enum delivery: { "貨運 NT$100": 100, "超商": 50 }
end
