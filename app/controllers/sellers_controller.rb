class SellersController < ApplicationController
  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)
    # render html: params
		if @seller.save
			redirect_to root_path, notice: '感謝您的申請'
		else
			render :new, notice: '請重新填寫'
		end
  end
  private
  def seller_params
    params.require(:seller).permit(:name, :email,:user_id)
  end
end
  
