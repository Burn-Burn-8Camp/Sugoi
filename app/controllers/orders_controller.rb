class OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_orders_by_state, only: [:pending, :processing, :shipped, :completed, :cancelled]
	before_action :find_order_by_friendly_id, only: [:show, :items_info]
	def index
		redirect_to pending_orders_path
	end

	def show
	end

	def items_info
		@items = @order.order_items.includes(:comment)
		render './orders/items_info.json.jbuilder'
	end

	def checkout
		@order = Order.new
		@items = current_cart.items
		find_by_smae_store(@store_items = [], @items)
	end

	def create
		@cart_items = current_cart.items
		find_by_smae_store(@store_items = [], @cart_items)
		@order = current_user.orders.new(order_params)
		@order.total = current_cart.total_included_delivery_fee
		create_order_items_data_in_order(@cart_items, @order)

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

		def find_order_by_friendly_id
			@order = current_user.orders.find_by_friendly_id!(params[:id])
		end

		def caculate_user_consume(user)
			order = user.orders.select{ |order| order.state != "cancelled" }
			total = order.map{|order| order.total}.sum
			user.update(accumulated_amount: total)
		end

		def create_order_items_data_in_order(cart_items, order)
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