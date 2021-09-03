class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :receiver, presence: true
  validates :tel, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates :delivery, presence: true
  
  
end
