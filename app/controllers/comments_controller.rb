class CommentsController < ApplicationController
	before_action  :authenticate_user!

	def buyer_comment
		@comment = current_user.comments.new(buyer_comment_params)
		if @comment.save
			redirect_to order_path(params[:order_id]), notice: '評價成功'
		else
			redirect_to order_path(params[:order_id]), notice: '評價失敗，請重新評價'
		end
	end

	def seller_comment
		@comment = current_store.seller_comments.new(seller_comment_params)
		if @comment.save
			redirect_to detail_store_order_path(params[:order_id]), notice: '賣家評價成功'
		else
			redirect_to detail_store_order_path(params[:order_id]), notice: '評價失敗，請重新評價'
		end
	end

	private
		def buyer_comment_params
			params.permit(:order_item_id, :rate, :content)
		end

		def seller_comment_params
			params.permit(:rate, :content).merge(order_id: params[:order_real_id])
		end
end
