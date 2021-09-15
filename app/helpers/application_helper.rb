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

	def state_step(order, n)
		state_arr = ['pending', 'paid', 'picked', 'in_transit', 'arrived', 'cancelled']
		state_arr.index(order.state) < n ? 'step' : 'step step-primary'
	end

	def store_item_total(item_arr)
		item_arr.map{ |item| item.total}.sum
	end
	def product_storage(id)
    Product.find(id).quantity
  end

	def cart_items_amount
		items = current_cart.items.map { |item| item.quantity } 
		items.sum      
	end
end
