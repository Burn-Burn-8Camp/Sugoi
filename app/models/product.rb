class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items
	has_many :bookmarks
	has_many :users, 
	         through: :bookmarks
	enum delivery: { "貨運 NT$100": 100, "超商": 50 }
	include AASM
end
