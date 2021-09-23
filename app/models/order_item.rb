class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :store
  has_one :comment
end
