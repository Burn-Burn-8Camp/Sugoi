class OrdersController < ApplicationController
	before_action  :authenticate_user!
	before_action :find_orders_by_state, only: [:index, :pending, :processing, :shipped, :completed, :cancelled]
	def index
		redirect_to pending_orders_path
	end

	def show
		@order = current_user.orders.find_by_friendly_id!(params[:id])
		@items = @order.order_items.includes(:product)
		@store_items = []
		find_by_smae_store(@store_items, @items)
	end

	def checkout
		@order = Order.new
		@store_id_list = current_cart.items.map { |item| item.store_id }.uniq.sort
    @store_items = []
    @store_id_list.each{ |id|
      @store_items << current_cart.items.select{ |item|
        item.store_id === id 
     }
    }
	end

	def create
		@cart_items = current_cart.items
		@cart_coupon = current_cart.coupon
		@order = current_user.orders.new(order_params)		
		@order.total = current_cart.total_included_delivery_fee
		create_order_items_data_in_order(@cart_items, @order)

		@cart_coupon.each do |coupon| 
			@order.total = @order.total - coupon.coupon_value.to_i
			current_user.user_coupons.find_by(coupon_id: coupon.coupon_id).redeem!
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
		@orders = current_user.orders.where(state: 'pending').order(id: :desc)
		render :index
	end

	def processing
		@orders = current_user.orders.where(state: ['paid', 'picked']).order(id: :desc)
		render :index
	end

	def shipped
		@orders = current_user.orders.where(state: 'in_transit').order(id: :desc)
		render :index
	end

	def completed
		@orders = current_user.orders.where(state: 'arrived').order(id: :desc)
		render :index
	end
	
	def cancelled
		@orders = current_user.orders.where(state: 'cancelled').order(id: :desc)
		render :index
	end

	private
		def order_params
			params.require(:order).permit(:receiver, :tel, :email, :address, :delivery)
		end

		def caculate_user_consume(user)
			order = user.orders.select{ |order| order.state != "cancelled" }
			total = order.map{|order| order.total}.sum
			user.update(accumulated_amount: total)
		end

		def create_order_items_data_in_order(cart_items, order)
			store_id_list = []
			# 購物車商品建立資料
			cart_items.each do |item|
				order_items = OrderItem.new(
					name: item.name,
					price: item.price,
					quantity: item.quantity,
					product_id: item.product_id,
					store_id: item.store_id
				)
				# 建立商品實體塞進order.order_items
				order.order_items << order_items
				# 建立商店id序號
				store_id_list << item.store
			end
			# 建立store跟order的多對多關聯
			store_id_list.uniq.each{ |id|
				order.stores << id
			}
		end

		def find_by_smae_store(store_items, items)
			# 建立不重複的商店id陣列
			store_id_list = items.map { |item| item.store_id }.uniq.sort
			# 透過 store_id_list 把商品分類
			store_id_list.each{ |id|
				store_items << items.select{ |item|
				item.store_id === id 
				}
			}
		end

		def find_orders_by_state
			@pending_orders = current_user.orders.where(state: 'pending').order(id: :desc)
			@processing_orders = current_user.orders.where(state: ['paid', 'picked']).order(id: :desc)
			@shipped_orders = current_user.orders.where(state: 'in_transit').order(id: :desc)
			@completed_orders = current_user.orders.where(state: 'arrived').order(id: :desc)
			@cancelled_orders = current_user.orders.where(state: 'cancelled').order(id: :desc)
		end
end