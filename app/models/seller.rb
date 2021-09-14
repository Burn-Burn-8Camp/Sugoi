class Seller < ApplicationRecord
  # has_one :store
  # belongs_to :user
  include AASM
  aasm column: 'state' do
    state :application, initial: true
    state :pass_through, :cancelled 
  
    event :pass do
    transitions from: :application, to: :pass_through
    end

    event :cancel do
    transitions from: [:application, :pass_through], to: :cancelled
    end
  end  
end
