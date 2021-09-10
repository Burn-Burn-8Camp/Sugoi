class Order < ApplicationRecord
  has_many :order_items
  has_many :store_orders
  has_many :stores, through: :store_orders
  belongs_to :user

  validates :receiver, presence: true
  validates :tel, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :delivery, presence: true
  

  after_create :order_num_generator
  
  include AASM
  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :picked, :in_transit, :arrived, :cancelled, :returned
  
    event :pay do
    transitions from: :pending, to: :paid
    end
  
    event :pick do
    transitions from: :paid, to: :picked
    end

    event :transport do
    transitions from: :picked, to: :in_transit
    end
  
    event :arrive do
    transitions from: :in_transit, to: :arrived
    end

    event :cancel do
    transitions from: [:pending, :paid, :picked], to: :cancelled
    end

    event :return do
    transitions from: :arrived, to: :returned
    end
  end

  private
    def paddingZero(num, digits)
      (("0" * digits) + num.to_s).last(digits)
    end
    # 補0
    def order_num_generator
      today = Time.now
      serial = today.strftime("%Y%m%d%m%s")

      self.serial = "OD#{serial}#{paddingZero(self.id, 6)}"
      self.save
    end
    # 產生訂單序號
end
