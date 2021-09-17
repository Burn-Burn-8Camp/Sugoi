class CartsController < ApplicationController
  before_action  :authenticate_user!, only: [:add]
  before_action :find_cart_item, only: [:add]

  def show
    store_id_list = current_cart.items.map { |item| item.store_id }.uniq.sort
    @store_items = []
    store_id_list.each{ |id|
      @store_items << current_cart.items.select{ |item|
        item.store_id === id 
     }
    }
    @cart = current_cart.items
  end

  def add
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
    session[:cart1289] = current_cart.serialize
    @cart = current_cart.total
    render json: @cart  
  end

  private
    def find_cart_item
      @product = Product.find(params[:id])
    end
end