class OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_order_by_friendly_id, only: [:show, :items_info]
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
		@items = @order.order_items.includes(:comment)
		find_by_smae_store(@store_items = [], @items)
		render './orders/items_info.json.jbuilder'
	end

	def checkout
		@order = Order.new
		@items = current_cart.items
		find_by_smae_store(@store_items = [], @items)
	end

	def create
		cart_items = current_cart.items
		find_by_smae_store(@store_items = [], cart_items)
		@order = current_user.orders.new(order_params)
		@cart_coupon = current_cart.coupon
		create_order_items_in_order(cart_items, @order)

		@cart_coupon.each do |coupon| 
			if current_user.user_coupons.find_by(coupon_id: coupon.coupon_id).status === "unused"
				current_user.user_coupons.find_by(coupon_id: coupon.coupon_id).redeem!
			end
		end

		if @order.save			
			caculate_user_consume(current_user)
			session[:cart1289] = nil
			UserMailer.order_letter_confirm(@order).deliver_now
			redirect_to payment_order_path(@order), notice: '訂單成立'
		else
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

	private
		def order_params
			pm = params.require(:order).permit(:receiver, :tel, :email, :address, :delivery, :message, :product_subtotal, :coupon_value, :delivery_fee, :user_discount, :total)
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
				order_items = OrderItem.new(
					name: item.name,
					price: item.price,
					quantity: item.quantity,
					product_id: item.product_id,
					store_id: item.store_id
				)

				order.order_items << order_items
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
end