class Product < ApplicationRecord
	acts_as_paranoid
	belongs_to :store
	has_many :order_items
	has_many :comments


	extend FriendlyId
  friendly_id :name, use: :slugged
	has_many :bookmarks
	has_many :users, 
	         through: :bookmarks
	enum delivery: { "貨運 NT$100": 100 }
	has_one_attached :picture
end
