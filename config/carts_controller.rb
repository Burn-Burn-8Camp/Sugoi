class CartsController < ApplicationController
  before_action  :authenticate_user!, only: [:add]
  before_action :find_cart_item, only: [:add]

  def show
    @cart = current_cart.items
  end

  def add
    current_cart.add_item(params[:id], @product.name, @product.store.name, @product.price)
    session[:cart1289] = current_cart.serialize
    redirect_to product_path(params[:id]), notice: "已加至購物車"
  end

  def destroy
    session[:cart1289] = nil
    redirect_to root_path, notice: "購物車已清除"
  end

  def confirm
    
  #  render json: params
    
    current_cart.change_item_quantity(params[:product_id], params[:quantity])
    # render json: current_cart.items
    session[:cart1289] = current_cart.serialize

    redirect_to cart_path
    
  end

  private
  def find_cart_item
    @product = Product.find(params[:id])
  end
end