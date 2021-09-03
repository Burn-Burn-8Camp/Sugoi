class TestsController < ApplicationController 
  def index
    @products = Product.all
  end

  
end
