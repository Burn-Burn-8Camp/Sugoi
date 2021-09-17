class SellersController < ApplicationController
  before_action  :authenticate_user!

  def edit
  end

  def create
  end

  def update
    if current_user.update(seller_params)
      UserMailer.current_user_to_seller_letter_confirm(current_user).deliver_now
			redirect_to root_path, notice: '感謝您的申請'
		else
			render :new, notice: '請重新填寫'
		end
  end
 
  def seller_verify
    if current_user.update(verify_params)
      redirect_to verified_store_path
    else
      render :verify, notice:"資料錯誤"
    end
  end   

  def verified 
    if current_user.captcha === 5487587
      current_user.update(role:"seller",ver)
      redirect_to root_path, notice:"恭喜您成為賣家"
    else
      redirect_to verify_store_path, notice: "驗證碼錯誤"
    end
  end
 
  def verify
  end
  
  private
    def seller_params
      params.require(:user).permit(:seller_email, :seller_name)
    end

    def verify_params
      params.require(:user).permit(:captcha)
    end
end
  
