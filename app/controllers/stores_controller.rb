class StoresController < ApplicationController
	before_action  :authenticate_user!
	before_action :find_store, except: [:show, :new]
	def show

	end
	
	def products_list
		@products = current_store.products.all
	end
	def product_detail
		@product = current_store.products.find(params[:id])
	end

	def orders_list

	end
	def order_detail

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

	end



	private
	def store_params
		params.require(:store).permit(:name, :user_id, :introduction)
	end
	def find_store
		@store = current_user.store
	end
end
