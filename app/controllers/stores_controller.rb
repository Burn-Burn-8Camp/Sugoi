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
		
		if params[:start_on].present?
			@orders = @orders.where( "orders.created_at >= ?", "#{Date.parse(params[:start_on]).beginning_of_day}" )
  	end
			
		if params[:end_on].present?
			@orders = @orders.where( "orders.created_at <= ?", "#{Date.parse(params[:end_on]).end_of_day}" )
		end
	end

	def order_detail
	  @order = current_store.orders.friendly.find(params[:id])
	  @items = OrderItem.where(order_id: @order, store_id: current_store.id)
		# 所有商家出貨確認
		@store_order = @order.store_orders.find_by(store_id: current_store.id)
		@order.transport! if @order.may_transport? &&	@order.store_orders.any? {|order| order.shipment_confirm != false}	
	end

	def shipment
		order = current_store.orders.friendly.find(params[:id])
		store_order = order.store_orders.find_by(store_id: current_store.id)
		if order.may_transport?
			store_order.update(shipment_confirm: true)
			redirect_to detail_store_order_path, notice: "成功出貨"
		else
			redirect_to detail_store_order_path, notice: "訂單尚未付款，請勿出貨"
		end
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
