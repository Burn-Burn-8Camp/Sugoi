class CouponsController < ApplicationController
  before_action  :authenticate_user!, only: [:get]
  def index
    @coupons = Coupon.order("id DESC")
  end

  def get
    @coupon = Coupon.find(params[:id])

    if check_coupon_id?(params[:id])
      redirect_to coupons_path, notice: "您先前已領取"
    else 
      current_user.coupons << @coupon
      current_user.user_coupons.find_by(coupon_id: params[:id]).take!
      redirect_to coupons_path, notice: "領取成功"
    end
  end

  def show
  end

  def check_coupon_id?(coupon_id)
    current_user.user_coupons.any? { |coupon| coupon.coupon_id == coupon_id.to_i }
  end

end