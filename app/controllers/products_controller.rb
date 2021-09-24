class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @products = pagy(Product.all, items: 6)
    @foods = Product.where(category: 'food').limit(6)
    @books = Product.where(category:'book').limit(6)
    @movies = Product.where(category: 'movie').limit(6)
    @animals = Product.where(category: 'animal').limit(6)
    @dragonBalls = Product.where(category: 'dragonBall').limit(6)

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
    @favorite_items = Bookmark.where(user_id: current_user, product_id: @product)  
    items = OrderItem.joins(:product, :comment).where(product_id: @product).select(:id)
    @comments = items.map{ |item| item.comment }
    
    @products = Product.find(params[:id])
  end

  def edit    
  end
  
  def update
  @product = current_store
    if @product.update(product_params)
      redirect_to product_path,notice: "修改成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy if @product
      redirect_to store_path,notice: "刪除成功"
  end

  def search 
    if params[:keyword]
      @products = Product.where("name LIKE ?", "%#{params[:keyword]}%")
     else
      @products = Product.all
     end
  end

  def favorite  
    product = Product.find(params[:id])
    if Bookmark.exists?(product: product) 
      current_user.favorite_items.delete(product)
      render json: { status: "removed", id: params[:id] }
    else
      current_user.favorite_items << product
      render json: { status: "added", id: params[:id] }
    end
  end  

  private
    def product_params
      params.require(:product).permit(:name, :price, :quantity, :description, :category, :material, :manufacturing_method, :country, :content, :store_id, :image)
    end

    def find_product
      @product = Product.find(params[:id])
    end
end





