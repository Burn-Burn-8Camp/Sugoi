class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @products = pagy(Product.where(deleted_at: nil), items: 6)
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
    item = OrderItem.joins(:product, :comment).where(product_id: @product).select(:id)
    users = item.map{ |i| i.comment.user}.reverse
    @comments = item.map{ |i| i.comment }.reverse
    @comments_with_users = @comments.zip(users)
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
      @product = Product.friendly.find(params[:id])
    end
end



  