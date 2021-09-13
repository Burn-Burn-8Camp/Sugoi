module ApplicationHelper
	include Pagy::Frontend

	def check_state(order)
		case order.state
			when "pending"
				'尚未付款'
			when "paid"
				"已付款"
			when "picked"
				"撿貨中"
			when "in_transit"
				"運送中"
			when "arrived"
				"已送達"
			when "cancelled"
				"已取消"
		end
	end

	def orders_length(orders)
		if orders
			orders.length
		else
			0
		end
	end
end
