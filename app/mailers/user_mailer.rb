class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #


  # template在app/views/user_mailer/notify_comment.text.erb(純文字格式)、notify_comment.html.erb(HTML格式)。

  default :from => "Sugoi 客服 <Sugoi@sugoi.com>"

  def notify_comment(user, comment)
    @comment = comment

    mail(to: user.email, :subject => "訂單成立") 
  end

  def order_letter_confirm(order, comment)
    @comment = comment
    @order = Order.last
    @order_items =  @order.order_items

    mail(to: order.email, :subject => "訂單成立") 
  end

end
