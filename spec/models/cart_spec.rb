require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do
    it "可以把商品丟到到購物車裡" do
      cart = Cart.new
      cart.add_product(1)
      expect(cart.empty?).to be false  
    end

    it "如果加了同種類商品到購物車，購買項目不會增加，但商品的數量會改變" do
      cart = Cart.new
      2.times(cart.add_product(1))
      5.times(cart.add_product(2))
      expect(cart.length).to be 2
      expect(cart.peoducts.first.quantity).to be 2
      expect(cart.peoducts.last.quantity).to be 5
    end
    
  end
  
end


# 。
# 。
# 商品可以放到購物車裡，也可以再拿出來。
# 每個 Cart Item 都可以計算它自己的金額（小計）。
# 可以計算整台購物車的總消費金額。
# 特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。