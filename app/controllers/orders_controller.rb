class OrdersController < ApplicationController
	before_action  :authenticate_user!, only: [:checkout]
	before_action :find_order, only: [:show]
	def index
		@orders = current_user.orders.all 
	end
	def show

	end
	def checkout
		@order = Order.new
		@deliveries = Delivery.all
	end

	def create
		order = current_user.orders.new(order_params)

		current_cart.items.each do |item|
			oi = OrderItem.new(
				name: item.name,
				price: item.product.price,
				quantity: item.quantity,
			)
			order.order_items << oi
		end

		order[:total] = current_cart.total

		if order.save
			session[:cart1289] = nil
			redirect_to payment_orders_path, notice: '訂單成立'
		else
			render html: "Fail"
		end
	end

	private
	def order_params
		params.require(:order).permit(:receiver, :tel, :email, :address, :delivery, :user_id)
	end

	def find_order
		@order = current_user.orders.find(params[:id])
	end
end