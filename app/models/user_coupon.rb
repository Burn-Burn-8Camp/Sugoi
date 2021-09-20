class UserCoupon < ApplicationRecord
  belongs_to :user
  belongs_to :coupon

  include AASM
  aasm column: 'status' do
    state :not_taken, initial: true
    state :unused, :used, :expired
  
    event :take do
    transitions from: :not_taken, to: :unused
    end
  
    event :redeem do
    transitions from: :unused, to: :used
    end

    event :expire do
    transitions from: [:not_taken, :unused, :used, :expired], to: :expired
    end
  end
end
