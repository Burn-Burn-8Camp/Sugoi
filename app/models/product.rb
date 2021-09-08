class Product < ApplicationRecord
	belongs_to :store
	has_many :order_items


	include AASM

end
