class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items
	has_many :bookmarks
	has_many :users, 
	         through: :bookmarks


	include AASM

end
