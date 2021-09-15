class OrdersController < ApplicationController
	before_action  :authenticate_user!, only: [:checkout, :index, :show]
	
	def index
		@orders = current_user.orders.all
	end

	def show
		@order = current_user.orders.find(params[:id])
		@items = @order.order_items.includes(:product)
	end

	def checkout
		@order = Order.new
		@cart_items = current_cart.items
	end

	def create
		order = current_user.orders.new(order_params)
		order[:total] = current_cart.total_included_delivery_fee
		store_id_list = []
		# 購物車商品填資料
		current_cart.items.each do |item|
			order_item = OrderItem.new(
				name: item.name,
				price: item.price,
				quantity: item.quantity,
				product_id: item.product_id
			)
			order.order_items << order_item
			store_id_list << item.store
		end
		
		store_id_list.uniq.each{ |id|
			order.stores << id
		}
		
		if order.save			
			session[:cart1289] = nil
			UserMailer.order_letter_confirm(order).deliver_now
			redirect_to payment_order_path(order), notice: '訂單成立'
		
		else
			render html: "Fail"
		end
	end

	private
		def order_params
			params.require(:order).permit(:receiver, :tel, :email, :address, :delivery)
		end

end