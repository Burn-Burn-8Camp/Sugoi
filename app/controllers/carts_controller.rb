class CartsController < ApplicationController
  def show
  end

  def add

    cart = Cart.new
    cart.add_item(params[:id])
    session[:cart1298] = cart.serialize

    redirect
  end

end