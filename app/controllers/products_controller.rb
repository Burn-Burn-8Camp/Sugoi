class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:keyword]
      @pagy, @products = pagy(Product.where([`name like '%?%'`, params[:keyword]]), items: 6)
    else
      @pagy, @products = pagy(Product.all, items: 6)
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to list_store_products_path, notice: "新增成功"
    else
      render :new
    end
  end

  def show  
  end

  def edit    
  end
  
  def update
    if @product.update(product_params)
      redirect_to products_path,notice: "修改成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy if @product
      redirect_to products_path,notice: "刪除成功"
  end

  def search 
    # @keyword = params[:keyword]
    # render html: params
    if params[:keyword]
      @products = Product.where("name LIKE ?", "%#{params[:keyword]}%")
     else
      @products = Product.all
     end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :quantity, :description, :category, :material, :manufacturing_method, :country, :content, :store_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end





