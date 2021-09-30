class Product < ApplicationRecord
	acts_as_paranoid
	extend FriendlyId
  	friendly_id :name, use: :slugged
	validates_presence_of :name, :price, :quantity, :category, :content 
	
	
	enum delivery: { "貨運 NT$100": 100 }

	belongs_to :store
	has_many :order_items
	has_many :comments
	has_many :bookmarks
	has_many :users, through: :bookmarks
	has_one_attached :picture
	mount_uploader :image, ImageUploader

	has_many :rooms
	has_many :users, through: :rooms
end
