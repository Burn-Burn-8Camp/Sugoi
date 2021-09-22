module ApplicationHelper
	include Pagy::Frontend

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
		elsif day < 7
			"#{day}天前"
		elsif day > 7 && day < 30
			"#{(day / 7.0).floor}週前"
		else
			"#{(day / 30).floor}個月前"
		end
	end

	def calculate_star_average(comments)
		comments.map{|comment| comment.rate}.sum / comments.length
	end
end