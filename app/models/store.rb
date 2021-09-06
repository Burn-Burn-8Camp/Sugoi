class Store < ApplicationRecord
  has_many :orders
  has_many :products
  belongs_to :user

  validates :name, presence: true, uniqueness: true



end
