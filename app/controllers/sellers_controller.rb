class SellersController < ApplicationController
  before_action  :authenticate_user!

  def edit
  end

  def create
    p "CY好帥"
  end

  def update
    if current_user.update(seller_params)
      UserMailer.current_user_to_seller_letter_confirm(current_user).deliver_now
			redirect_to root_path, notice: '感謝您的申請'
      current_user.update(role:"seller")
		else
			render :new, notice: '請重新填寫'
		end
  end

  # def seller_verify
  #   if current_user.role != "seller"
  #     current_user.update(role:"seller")
  #   else
  #     redirect_to root_path, notice: "您已經是賣家"
  #   end
  # end

  private
    def seller_params
      params.require(:user).permit(:seller_email, :seller_name)
    end


end
  
