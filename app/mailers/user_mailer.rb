class UserMailer < ApplicationMailer
  # template在app/views/user_mailer/notify_comment.text.erb(純文字格式)、notify_comment.html.erb(HTML格式)。
  default :from => "Sugoi 客服 <Sugoi@sugoi.com>"

  def order_letter_confirm(order)
    @order = order
    @order_items =  @order.order_items

    mail(to: order.email, :subject => "訂單成立") 
  end

  def current_user_to_seller_letter_confirm(current_user)
    @user = current_user
    # @order_items =  @order.order_items

    mail(to: current_user.seller_email, :subject => "申請成為賣家驗證信") 
  end
end
