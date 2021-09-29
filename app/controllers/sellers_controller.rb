class SellersController < ApplicationController
  before_action  :authenticate_user!

  def verify
  end

  def update
    if current_user.update(seller_params)
      begin
        UserMailer.current_user_to_seller_letter_confirm(current_user).deliver_now
			  redirect_to root_path, notice: '感謝您的申請'
      rescue
        redirect_to application_store_path, notice: '資料不可為空'
      end
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
    if current_user.captcha === 123456
      current_user.update(role:"seller")
      current_user.update(valid_at: Time.now)
      redirect_to root_path, notice:"恭喜您成為賣家"
    else
      redirect_to verify_store_path, notice: "驗證碼錯誤"
    end
  end
 
  private
    def seller_params
      params.require(:user).permit(:seller_email, :seller_name)
    end

    def verify_params
      params.require(:user).permit(:captcha)
    end
end