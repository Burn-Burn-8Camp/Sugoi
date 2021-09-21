class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:notify_response]
	before_action :find_order, only: [:payment]
	# 前往付錢
	def payment
		if @order.may_pay?
			# @form_info = Newebpay::Mpg.new(@order).form_info
			# @form_data = Newebpay::Mpg.new(@order).info
		# else
			redirect_to orders_path
		end
	end

	# 付錢回來
	def notify_response
		check_response(return_params(params))
	end
	private
		def check_response(params)
			response = Newebpay::MpgResponse.new(params[:TradeInfo])
			order = Order.find_by(serial: response.order_no)
			sign_in order.user

			if response.success?
				order.pay!
				redirect_to order_path(order), notice: '刷卡成功'
			else
				redirect_to payment_order_path(order), notice: '刷卡失敗，請重新付款'
			end
		end

		def return_params(params)
			params.permit(:Status, :MerchantID, :Version, :TradeInfo, :TradeSha)
		end

		def find_order
			@order = current_user.orders.find_by_friendly_id!(params[:id])
		end
end
