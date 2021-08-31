class ProductsController < ApplicationController
  def index

  end



    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path,notice: "新增成功"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path,notice: "修改成功"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy if @product
      redirect_to products_path,notice: "刪除成功"
  end

  def show
  end


  private
  def product_params
    params.require(:product).permit(:name, :price, :quantity, :describtion, :category, :material, :manufacturing_method, :country, :content)
  end
end



