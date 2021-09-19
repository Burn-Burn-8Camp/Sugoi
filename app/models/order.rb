class Order < ApplicationRecord
  has_many :order_items
  has_many :store_orders
  has_many :stores, through: :store_orders
  belongs_to :user

  after_create :order_num_generator

  validates_presence_of :receiver, :tel, :email, :address, :delivery
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  extend FriendlyId
  friendly_id :receiver, use: :slugged

  include AASM
  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :in_transit, :arrived, :cancelled, :returned
  
    event :pay do
    transitions from: :pending, to: :paid
    end
  
    event :transport do
    transitions from: :paid, to: :in_transit
    end
  
    event :arrive do
    transitions from: :in_transit, to: :arrived
    end

    event :cancel do
    transitions from: [:pending, :paid], to: :cancelled
    end

    event :return do
    transitions from: :arrived, to: :returned
    end
  end

  private
    def paddingZero(num, digits)
      (("0" * digits) + num.to_s).last(digits)
    end

    def order_num_generator
      today = Time.now
      serial = today.strftime("%Y%m%d")

      self.serial = "OD#{serial}#{paddingZero(self.id, 6)}"
      self.save
    end
end
