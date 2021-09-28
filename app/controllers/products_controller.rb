class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  
  def index
    # @pagy, @products = pagy(Product.where(deleted_at: nil), items: 6)
    @products = Product.all.order(id: :desc)
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
    @favorite_item = Bookmark.where(user_id: current_user, product_id: @product)  
    
    @products = Product.friendly.find(params[:id])
    item = OrderItem.joins(:product, :comment).where(product_id: @product).select(:id)
    users = item.map{ |i| i.comment.user}.reverse
    @comments = item.map{ |i| i.comment }.reverse
    @comments_with_users = @comments.zip(users)
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
      redirect_to list_store_products_path, notice: "刪除成功"
  end

  def search 
    if params[:keyword]
      @products = Product.where("name LIKE ?", "%#{params[:keyword]}%")
     else
      @products = Product.all
     end
  end

  def favorite  
    product = Product.friendly.find(params[:id])
    if Bookmark.exists?(product: product, user: current_user) 
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
      @product = Product.friendly.find(params[:id])
    end
end



  