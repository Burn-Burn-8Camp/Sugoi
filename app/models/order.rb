class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  after_create :order_num_generator
  
  validates :receiver, presence: true
  validates :tel, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :delivery, presence: true
  
  private
  def paddingZero(num, digits)
    (("0" * digits) + num.to_s).last(digits)
  end
  # 補0
  def order_num_generator
    today = Time.now
    serial = today.strftime("%Y%m%d")

    self.serial = "OD#{serial}#{paddingZero(self.id, 6)}"
    self.save
  end
  # 產生訂單序號
end
