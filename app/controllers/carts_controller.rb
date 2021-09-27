class CartsController < ApplicationController
  before_action  :authenticate_user!, only: [:add_item, :show]
  before_action :find_cart_item, only: [:add_item]

  def show
    @coupons = current_user.user_coupons.where(status: "unused")
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
    current_cart.add_item(@product.id, @product.name, @product.store.id, @product.store.name, @product.price)
    session[:cart1289] = current_cart.serialize
    redirect_to product_path(params[:id]), notice: "已加至購物車"
  end

  def delete_item
    current_cart.items.select! { |item| item.product_id != params[:product_id].to_i }
    delivery_fee = Product.deliveries["貨運 NT$100"]
    subtotal = current_cart.items.reduce(0) { |acc, item| acc + item.price.to_i } 
    session[:cart1289] = current_cart.serialize
    render json: { delivery_fee: delivery_fee, subtotal: subtotal, itemsQuantity: current_cart.items.count }
  end

  def destroy
    session[:cart1289] = nil
    redirect_to root_path, notice: "購物車已清除"
  end

  def confirm
    current_cart.change_item_quantity(params[:product_id], params[:quantity])
    session[:cart1289] = current_cart.serialize
    itemsPrice = current_cart.total
    items_quantity = current_cart.items.count
    render json: { itemsPrice: current_cart.total }
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