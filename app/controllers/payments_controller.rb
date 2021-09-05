class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:notify_response]
	def payment
		@order = current_user.orders.find(params[:id])
		@form_info = Newebpay::Mpg.new(@order).form_info
		@form_data = Newebpay::Mpg.new(@order).info
	end

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
			order.cancel!
			redirect_to order_path(order), notice: '刷卡失敗，訂單取消'
		end
	end

	def return_params(params)
		params.permit(:Status, :MerchantID, :Version, :TradeInfo, :TradeSha)
	end
end
