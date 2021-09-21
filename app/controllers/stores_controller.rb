class StoresController < ApplicationController
	before_action  :authenticate_user!
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
	end

	def update
		if @store.update(store_params)
			redirect_to store_path, notice: '更新成功'
		else
			render :edit, notice: '請重新填寫'
		end
	end
	
	def products_list
		@products = current_store.products.all
	end

	def product_detail
		@product = current_store.products.find(params[:id])
	end

	def orders_list
		@orders = current_store.orders.all
	end

	def order_detail
		@order = current_store.orders.find_by_friendly_id!(params[:id])
		@items = @order.order_items.includes(:store).where(store: current_store)
	end
	
	private
		def store_params
			params.require(:store).permit(:name, :user_id, :introduction)
		end
		
		def find_store
			@store = current_user.store
		end
end
