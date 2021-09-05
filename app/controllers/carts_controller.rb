class CartsController < ApplicationController
  before_action  :authenticate_user!, only: [:add]
  before_action :find_cart_item, only: [:add]

  def show
  end

  def add
    current_cart.add_item(params[:id], @product.name)
    session[:cart1289] = current_cart.serialize
    redirect_to product_path(params[:id]), notice: "已加至購物車"
  end

  def destroy
    session[:cart1289] = nil
    redirect_to root_path, notice: "購物車已清除"
  end

  private
  def find_cart_item
    @product = Product.find(params[:id])
  end
end