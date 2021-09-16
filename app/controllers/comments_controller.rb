class CommentsController < ApplicationController
	def create
		@comment = current_user.comments.new(comment_params)
		if @comment.save
			redirect_to order_path(params[:order_id]), notice: '評價成功'
		else
			redirect_to order_path(params[:order_id]), notice: '評價失敗，請重新評價'
		end
	end

	private
		def comment_params
			params.permit(:product_id, :rate, :content)
		end
end
