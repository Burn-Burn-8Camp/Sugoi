class OrdersController < ApplicationController
	def cart
		@order = Order.new
	end
	def create
		order = current_user.orders.bulid(order_params)

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
			redirect_to '', notice: '訂單成立'
		else
			alert
		end
	end

	private
	def order_params
		params.require(:order).permit(:receiver, :tel, :address, :email, :delivery)
	end
end