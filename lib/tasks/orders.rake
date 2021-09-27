namespace :orders do
	desc "Generate fake orders"
	task :fake => :environment do
		def user_discount(accumulated_amount, products_with_coupon_and_fee)
			if accumulated_amount > 2000 && accumulated_amount < 20000
				(products_with_coupon_and_fee * 0.05).ceil 
			elsif accumulated_amount >= 20000
				(products_with_coupon_and_fee * 0.15).ceil 
			else
				0
			end      
		end

		def caculate_user_consume(user)
			total = user.orders.where.not( state: "cancelled" ).sum(:total)
			user.update(accumulated_amount: total)
		end

		10.times do |i|
			user = User.all.sample
			products = Product.all.sample(5)
			products_subtotal = products.map{|product| product.price.to_i}.sum
			coupon_value = [50, 100, 200, 250, 300].sample
			products_with_coupon_and_fee = products_subtotal - coupon_value + 100
			user_discount = user_discount(user.accumulated_amount, products_with_coupon_and_fee)
			total = products_with_coupon_and_fee - user_discount

			order = user.orders.new(
				receiver: '小美',
				tel: '0988552367',
				address: '台北市中正路1號6樓',
				email: 'fff@gmail.com',
				delivery: '貨運',
				product_subtotal: products_subtotal,
				coupon_value: coupon_value,
				delivery_fee: 100,
				user_discount: user_discount,
				total: total
			)

			store_id_list = []
			products.each{ |item|
				order_items = OrderItem.new(
					name: item.name,
					price: item.price,
					quantity: item.quantity,
					product_id: item.id,
					store_id: item.store_id
				)

				order.order_items << order_items
				store_id_list << item.store
			}
			store_id_list.uniq.each{ |id|
				order.stores << id
			}
			order.save
			caculate_user_consume(user)
		end
		puts "done!"
	end
end

desc "order run"
task :order_run => :environment do
	orders = Order.where(state: 'in_transit')
	orders.each{ |order| order.arrive!}
	p done
end