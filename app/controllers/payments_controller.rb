class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:notify_response]
	def payment
		@order = current_user.orders.find(params[:id])
		@form_info = Newebpay::Mpg.new(@order).form_info
		@form_data = Newebpay::Mpg.new(@order).info
	end

	def notify_response
		response = Newebpay::MpgResponse.new(params[:TradeInfo])
		order = Order.find_by(serial: response.order_no)
		sign_in order.user
		order.pay! if response.success?
		redirect_to orders_path, notice: '刷卡成功'
	end

end
