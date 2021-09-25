class CartCoupon
  attr_reader :coupon_id, :coupon_value

  def initialize(coupon_id, coupon_value)
    @coupon_id = coupon_id
    @coupon_value = coupon_value
  end
end