module OrdersHelper
	def check_state(order)
		case order.state
			when "pending"
				'尚未付款'
			when "paid"
				"已付款"
			when "in_transit"
				"運送中"
			when "arrived"
				"已送達"
			when "cancelled"
				"已取消"
		end
	end

	def state_step(order, n)
		state_arr = ['pending', 'paid', 'in_transit', 'arrived', 'cancelled']
		state_arr.index(order.state) < n ? 'step' : 'step step-primary'
	end

	def seller_state_step(order, n)
		state_arr = ['pending', 'paid', 'in_transit', 'arrived', 'cancelled']
		state_arr.index(order.state) < n ? 'step' : 'step step-success'
	end
end