class OrdersController < ApplicationController
	before_action  :authenticate_user!, only: [:checkout, :index, :show]
	
	def index
		@orders = current_user.orders.all
	end

	def show
		@order = current_user.orders.find_by_friendly_id!(params[:id])
		@items = @order.order_items.includes(:product)
		@store_items = []
		find_by_smae_store(@store_items, @items)
	end

	def checkout
		@order = Order.new
		@cart_items = current_cart.items
	end

	def create
		@cart_items = current_cart.items
		@order = current_user.orders.new(order_params)
		@order[:total] = current_cart.total
		create_order_items_data_in_order(@cart_items, @order)
		if @order.save			
			caculate_user_consume(current_user)
			session[:cart1289] = nil
			redirect_to payment_order_path(@order), notice: '訂單成立'
		else
			render :checkout
		end
	end

	private
		def order_params
			params.require(:order).permit(:receiver, :tel, :email, :address, :delivery)
		end

		def caculate_user_consume(user)
			order = user.orders.select{ |order| order.state != "cancelled" }
			total = order.map{|order| order[:total]}.sum
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
end