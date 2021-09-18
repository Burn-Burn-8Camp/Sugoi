class StoresController < ApplicationController
	before_action :authenticate_user!
	before_action :require_seller!
	before_action :find_store, except: [:show, :new]

	def show
	end

	def new
	  @store = Store.new
	end

	def create
	  @store = Store.new(store_params)
	  if @store.save
	  redirect_to store_path, notice: '商店創建成功'
	  else
	  render :new, notice: '請重新填寫'
	  end
	end

	def edit
	  @store = current_store
	end

	def update
	  if @store.update(store_params)
	    redirect_to store_path, notice: "修改成功"
	  else
		render :edit
	  end
	end
	
	def products_list
	  @products = current_store.products
	end

	def product_detail
	  @product = current_store.products.friendly.find(params[:id])
	end

	def orders_list
	  @orders = current_store.orders
	end

	def order_detail
	  @order = current_store.orders.friendly.find(params[:id])
	  @items = @order.order_items.includes(:product)
	end

	private
	  def store_params
			params.require(:store).permit(:name, :user_id, :introduction)
	  end
		
	  def find_store
			@store = current_user.store 
	  end

	  def require_seller!
			if current_user.role != "seller"
				flash[:alert] = "您的權限不足"
				redirect_to root_path
			end
	  end
end
