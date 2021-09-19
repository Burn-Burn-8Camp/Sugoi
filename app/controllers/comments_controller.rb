class CommentsController < ApplicationController
	before_action  :authenticate_user!

	def buyer_comment
		@comment = current_user.comments.new(comment_params)
		if @comment.save
			redirect_to order_path(params[:order_id]), notice: '評價成功'
		else
			redirect_to order_path(params[:order_id]), notice: '評價失敗，請重新評價'
		end
	end

	def seller_comment
		render html: params
	end

	private
		def comment_params
			params.permit(:order_item_id, :rate, :content)
		end
end
