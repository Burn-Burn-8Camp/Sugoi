class UserMailer < ApplicationMailer
  default :from => "SUGOII 客服 <sugoii@sugoii.live>"

  def order_letter_confirm(order)
    @order = order
    @order_items =  @order.order_items

    mail(to: order.email, :subject => "訂單成立") 
  end

end
