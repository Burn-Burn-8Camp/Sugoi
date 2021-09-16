require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do

    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1, 'ring')
      expect(cart.empty?).to be false
    end

    it "加相同的商品，購買項目（CartItem）並不會增加，商品的數量會改變" do
      cart = Cart.new

      3.times { cart.add_item(1, 'ring') }
      5.times { cart.add_item(2, 'oil') }
      2.times { cart.add_item(1, 'ring') }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(1, 'ring') }
      5.times { cart.add_item(2, 'oil') }

      expect(cart.items.first.product.id).to be p1.id
      expect(cart.items.last.product.id).to be p2.id
    end

    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
     
      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 100)
      3.times { cart.add_item(p1.id, 'ring') }
    
      expect(cart.items.first.total).to be 300
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 10)
      p2 = FactoryBot.create(:product, price: 20)

      3.times { cart.add_item(p1.id, 'ring') }
      2.times { cart.add_item(p2.id, 'oil') }

      expect(cart.total).to be 70
    end

    it "兒童節全面 8 折" do
      t = Time.local(2008, 4, 4, 10, 5, 0)
      Timecop.travel(t)

      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 10)
      p2 = FactoryBot.create(:product, price: 20)

      3.times { cart.add_item(p1.id, 'ring') }
      2.times { cart.add_item(p2.id, 'oil') }

      expect(cart.total).to eq 56
    end
  end


  # describe "進階功能" do
  #   it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do
  #     cart = Cart.new
  #     p1 = FactoryBot.create(:product)
  #     p2 = FactoryBot.create(:product)

  #     5.times { cart.add_item(p1.id, 'ring') }
  #     9.times { cart.add_item(p2.id, 'oil') }

  #     expect(cart.serialize).to eq cart_hash
  #   end


  #   it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容" do
  #     cart = Cart.from_hash(cart_hash)

  #     expect(cart.items.count).to be 2
  #     expect(cart.items.first.quantity).to be 5
  #   end

  #   private    
  #   def cart_hash
  #     {
  #       "items" => [
  #         { "product_id" => 1, "quantity" => 5, "name" => 'ring'},
  #         { "product_id" => 2, "quantity" => 9, "name" => 'oil' }
  #       ]
  #     }
  #   end
  # end
end
