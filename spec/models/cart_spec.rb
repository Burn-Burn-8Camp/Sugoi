require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do

    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1, 'ring', 1, "Bigshop", 100)
      expect(cart.empty?).to be false
    end

    it "加相同的商品，購買項目（CartItem）並不會增加，商品的數量會改變" do
      cart = Cart.new

      3.times { cart.add_item(1, 'ring', 1, "Bigshop", 100) }
      5.times { cart.add_item(2, 'oil', 2, "Smallshop", 400) }
      2.times { cart.add_item(1, 'ring', 1, "Bigshop", 100) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new
      (1..3).each{ |i| 
        user = User.new(email: "#{i}@gmail.com", 
                 password: "password", 
                 password_confirmation: "password")
        user.save!
        store = Store.new(user_id: i, name: "#{i}-store")
        store.save!
      }
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(p1.id, p1.name, p1.store_id, p1.store.name, p1.price) }
      5.times { cart.add_item(p2.id, p2.name, p2.store_id, p2.store.name, p2.price) }

      expect(cart.items.first.product_id).to be p1.id
      expect(cart.items.last.product_id).to be p2.id
    end

    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
      cart = Cart.new
      p1 = FactoryBot.create(:product)
      
      3.times { cart.add_item(p1.id, p1.name, p1.store_id, p1.store.name, p1.price) }
    
      expect(cart.items.first.total).to be p1.price.to_i * 3
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(p1.id, p1.name, p1.store_id, p1.store.name, p1.price) }
      5.times { cart.add_item(p2.id, p2.name, p2.store_id, p2.store.name, p2.price) }

      expect(cart.total).to be p1.price.to_i * 3 + p2.price.to_i * 5
    end

    it "兒童節全面 8 折" do
      t = Time.local(2008, 4, 4, 10, 5, 0)
      Timecop.travel(t)

      cart = Cart.new
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(p1.id, p1.name, p1.store_id, p1.store.name, p1.price) }
      5.times { cart.add_item(p2.id, p2.name, p2.store_id, p2.store.name, p2.price) }

      expect(cart.total).to eq (p1.price.to_i * 3 + p2.price.to_i * 5) * 0.8
    end
  end


  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do
      cart = Cart.new
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(1, "milk", 1, "bigstore", 100) }
      3.times { cart.add_item(2, "oil", 2, "snallstore", 200) }
      
      expect(cart.serialize).to eq cart_hash
    end


    it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容" do
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
    end

    private    
    def cart_hash
      {
        "items" => [
          { "product_id" => 1, "name" => 'milk', "store_id" => 1, "store" => "bigstore", "price" => 100, "quantity" => 3},
          { "product_id" => 2, "name" => "oil", "store_id" => 2, "store" => "snallstore", "price" => 200, "quantity" => 3}
        ]
      }
    end
  end
end
