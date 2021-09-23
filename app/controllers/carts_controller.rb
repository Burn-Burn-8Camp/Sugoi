class CartsController < ApplicationController
  before_action  :authenticate_user!, only: [:add]
  before_action :find_cart_item, only: [:add_item]

  def show
    # 相同商城會在同一欄位內
    @coupons = current_user.user_coupons
    store_id_list = current_cart.items.map { |item| item.store_id }.uniq.sort
    @store_items = []
    store_id_list.each{ |id|
      @store_items << current_cart.items.select{ |item|
        item.store_id === id 
      }
    }
    @cart = current_cart.items
  end

  def add_item
    current_cart.add_item(params[:id], @product.name, @product.store.id, @product.store.name, @product.price)
    session[:cart1289] = current_cart.serialize
    redirect_to product_path(params[:id]), notice: "已加至購物車"
  end

  def destroy
    session[:cart1289] = nil
    redirect_to root_path, notice: "購物車已清除"
  end

  def confirm 
    current_cart.change_item_quantity(params[:product_id], params[:quantity])
    # render json: current_cart.items
    session[:cart1289] = current_cart.serialize
    @cart = current_cart.total
    render json: @cart  
  end

  def redeem
    found_coupon
    @total = current_cart.use_coupon(params[:coupon_id], params[:value])
    session[:cart1289] = current_cart.serialize
    render json: { total: @total, value: params[:value].to_i }
  end
  
  private
    def find_cart_item
      @product = Product.friendly.find(params[:id])
    end

    def found_coupon
      @coupons = current_user.user_coupons
      found_coupon = @coupons.find { |coupon| coupon.id === params[:coupon_id] }
    end
end