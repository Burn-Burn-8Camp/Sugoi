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

	def delivery_fee
		delivery_fee = Product.deliveries["貨運 NT$100"] 
	end

	def total_delivery_fee
		delivery_fee * store_amount
	end

	def coupon_value
		current_cart.coupon.reduce(0) { |acc, coupon | acc + coupon.coupon_value.to_i }
	end

	def shopping_cart_sum
		current_cart.total_included_delivery_fee - coupon_value
	end

	def store_amount
    store_id_list = current_cart.items.map { |item| item.store_id }.uniq.sort
    @store_items = []
    store_id_list.each{ |id|
      @store_items << current_cart.items.select{ |item|
        item.store_id === id 
      }
    }
    @store_items.count
  end


end
