class Seller < ApplicationRecord
  has_one :store
  belongs_to :user
  include AASM
  aasm column: 'state' do
    state :successful_application, initial: true
    state :under_review, :pass_through, :cancelled, :Not_qualified 
  
    event :under_review do
    transitions from: :successful_application, to: :under_review
    end
  
    event :pass_through do
    transitions from: :under_review, to: :pass_through
    end

    event :cancel do
    transitions from: [:successful_application, :under_review], to: :cancelled
    end
  
    event :Not_qualified do
    transitions from: :under_review, to: :Not_qualified 
    end
  end  
end
