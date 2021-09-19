module ApplicationHelper
	include Pagy::Frontend

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

	def orders_length(orders)
		if orders
			orders.length
		else
			0
		end
	end

	def state_step(order, n)
		state_arr = ['pending', 'paid', 'in_transit', 'arrived', 'cancelled']
		state_arr.index(order.state) < n ? 'step' : 'step step-primary'
	end

	def store_item_total(item_arr)
		item_arr.map{ |item| item.total }.sum
	end
	
	def product_storage(id)
    Product.friendly.find(id).quantity
  end

	def cart_items_amount
		items = current_cart.items.map { |item| item.quantity } 
		items.sum      
	end

	def calculate_time_gap(datetime)
		gap = (Time.now - datetime)
		day = (gap / 86400.0).floor
		hour = (gap / 3600.0).floor
		if day < 1 && hour <= 1
			"1小時內"
		elsif day < 1
			"#{hour}小時前"
		elsif day < 30
			"#{(day / 7.0).floor}週前"
		else
			"#{(day / 30).floor}個月前"
		end
	end

	def calculate_star_average(comments)
		comments.map{|comment| comment.rate}.sum / comments.length
	end
end
