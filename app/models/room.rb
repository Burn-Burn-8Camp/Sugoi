class Room < ApplicationRecord
    has_many :messages
    # has_many :users, through: :messages

    belongs_to :product
    belongs_to :user
end
