module ApplicationHelper
	include Pagy::Frontend

	def check_state(order)
		case order.state
			when "pending"
				link_to '前往付款', payment_order_path(order), class: 'btn'
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
end
