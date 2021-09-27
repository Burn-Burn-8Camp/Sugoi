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

	def delivery_fee
		delivery_fee = Product.deliveries["貨運 NT$100"] 
	end

	def coupon_value
		current_cart.coupon.reduce(0) { |acc, coupon | acc + coupon.coupon_value.to_i }
	end

	def user_discount(accumulated_amount)
		shopping_cart_with_fee_and_coupon = current_cart.total_included_delivery_fee - coupon_value 
    if accumulated_amount > 2000 && accumulated_amount < 20000
			shopping_cart_with_fee_and_coupon -= (shopping_cart_with_fee_and_coupon * 0.95).ceil 
		else accumulated_amount >= 20000
			shopping_cart_with_fee_and_coupon -= (shopping_cart_with_fee_and_coupon * 0.85).ceil 
    end      
  end

	def final_shopping_cart_value(accumulated_amount)
		current_cart.total_included_delivery_fee - coupon_value - user_discount(accumulated_amount)
	end
end
