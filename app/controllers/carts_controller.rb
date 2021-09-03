class CartsController < ApplicationController
  def show
  end

  def add
    current_cart.add_item(params[:id], params[:name])
    session[:cart1289] = current_cart.serialize
    
    redirect_to tests_path, notice: "已加至購物車"
  end

  def destroy
    session[:cart1289] = nil
    redirect_to tests_path, notice: "購物車已清除"
  end

end