class UserMailer < ApplicationMailer
  # template在app/views/user_mailer/notify_comment.text.erb(純文字格式)、notify_comment.html.erb(HTML格式)。
  default :from => "Sugoii 客服 <sugoii@sugoii.live>"

  def order_letter_confirm(order)
    @order = order
    @order_items =  @order.order_items

    mail(to: order.email, :subject => "訂單成立") 
  end

  def current_user_to_seller_letter_confirm(current_user)
    @user = current_user
    @valid_code = "123456"
    mail(to: current_user.seller_email, :subject => "申請成為賣家驗證信") 
  end
end
