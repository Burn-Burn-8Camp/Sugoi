class OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_order_by_friendly_id, only: [:show, :items_info, :cancel_order]
	before_action :find_orders_by_state, only: [:pending, 
											 												:processing, 
																							:shipped, 
																							:completed, 
																							:cancelled, 
																							:returned]

	def index
		redirect_to pending_orders_path
	end

	def show
		@comments = @order.seller_comments.includes(:store)
	end

	def items_info
		@items = @order.order_items.includes(:comment).includes(:product)
		find_by_smae_store(@store_items = [], @items)
		render './orders/items_info.json.jbuilder'
	end

	def checkout
		coupon_value = 0
		coupon_value ||= current_cart.coupon[0].coupon_value.to_i
		total_price = current_cart.total_included_delivery_fee - coupon_value

		if current_cart.items.count === 0
			redirect_to root_path, notice: "未加入任何商品"
		elsif total_price <= 0
			redirect_to root_path, notice: "總金額不得為負"
		else
			@order = Order.new
			@items = current_cart.items
			find_by_smae_store(@store_items = [], @items)
		end
	end

	def create
		@order = current_user.orders.new(order_params)
		cart_items = current_cart.items
		cart_coupon = current_cart.coupon
		user_coupons = current_user.user_coupons

		@order.product_subtotal = current_cart.total
		@order.delivery_fee = 100
		
		if cart_coupon.length != 0
			if find_coupon(user_coupons, cart_coupon).status === "unused"
				find_coupon(user_coupons, cart_coupon).redeem!
				@order.coupon_value = cart_coupon.first.coupon_value.to_i
			end
		end
		
		total_with_fee_with_coupon =  @order.product_subtotal - @order.coupon_value + @order.delivery_fee
		@order.user_discount = user_discount(current_user.accumulated_amount, total_with_fee_with_coupon)

		@order.total = total_with_fee_with_coupon - @order.user_discount
		create_order_items_in_order(cart_items, @order)
		
		if @order.save			
			caculate_user_consume(current_user)
			session[:cart1289] = nil
			UserMailer.order_letter_confirm(@order).deliver_now
			redirect_to payment_order_path(@order), notice: '訂單成立'
		else
			find_by_smae_store(@store_items = [], cart_items)
			render :checkout
		end
	end

	def pending
		@orders = Order.where(user_id: current_user, state: 'pending').includes(:order_items)
		render :index
	end

	def processing
		@orders = Order.where(user_id: current_user, state: 'paid').includes(:order_items)
		render :index
	end

	def shipped
		@orders = Order.where(user_id: current_user, state: 'in_transit').includes(:order_items)
		render :index
	end

	def completed
		@orders = Order.where(user_id: current_user, state: 'arrived').includes(:order_items)
		render :index
	end
	
	def cancelled
		@orders = Order.where(user_id: current_user, state: 'cancelled').includes(:order_items)
		render :index
	end

	def cancel_order
		if @order.may_cancel?
			@order.cancel!
			redirect_to orders_path, notice: '退單成功'
		else
			redirect_to orders_path, notice: '訂單已出貨，無法執行退單' 
		end
	end

	private
		def order_params
			pm = params.require(:order).permit(:receiver, :tel, :email, :address, :delivery, :message)
			pm[:message].delete!("\r\n")
			pm
		end

		def find_order_by_friendly_id
			@order = current_user.orders.friendly.find(params[:id])
		end

		def caculate_user_consume(user)
			total = user.orders.where.not( state: "cancelled" ).sum(:total)
			user.update(accumulated_amount: total)
		end

		def create_order_items_in_order(cart_items, order)
			store_id_list = []
			cart_items.each{ |item|
				order_item = OrderItem.new(
					name: item.name,
					price: item.price,
					quantity: item.quantity,
					product_id: item.product_id,
					store_id: item.store_id
				)

				product = Product.find(item.product_id)
				product.update(quantity: (product.quantity - item.quantity))
				order.order_items << order_item
				store_id_list << item.store
			}

			store_id_list.uniq.each{ |id|
				order.stores << id
			}
		end

		def find_by_smae_store(store_items, items)
			store_id_list = items.map { |item| item.store_id }.uniq.sort
			store_id_list.each{ |id|
				store_items << items.select{ |item| item.store_id === id }
			}
		end

		def find_orders_by_state
			state_arr = ['pending', 'paid', 'in_transit', 'arrived', 'cancelled']
			orders = Order.where(user_id: current_user).select(:user_id, :state)
			states = orders.map{|order| order.state}
			@state_hash = {}
			state_arr.each{|state| @state_hash[state] = states.count(state)}
		end

		def user_discount(accumulated_amount, total_with_fee_with_coupon)
			if accumulated_amount > 2000 && accumulated_amount < 20000
				(total_with_fee_with_coupon * 0.05).ceil 
			elsif accumulated_amount >= 20000
				(total_with_fee_with_coupon * 0.15).ceil 
			else
				0
			end      
		end

		def find_coupon(user_coupons, cart_coupon)
			user_coupons.find_by(coupon_id: cart_coupon.first.coupon_id)
		end
end