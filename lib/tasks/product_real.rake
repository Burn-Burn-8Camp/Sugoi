namespace :products do
  desc "Generate fake coupons"
  task :real => :environment do
    product_list = [
      { store_id: 1, name: "香菇印章", price: 250, quantity: 7, category: '紙類', image: '1.jpg'},
      { store_id: 1, name: "動物人1貼紙", price: 200, quantity: 8, category: '紙類', image: '2.jpg'},
      { store_id: 1, name: "動物人2貼紙", price: 200, quantity: 2, category: '紙類', image: '3.jpg'},
      { store_id: 1, name: "動物人3貼紙", price: 200, quantity: 10, category: '紙類', image: '4.jpg'},
      { store_id: 1, name: "鐵器花卉貼紙", price: 200, quantity: 30, category: '紙類', image: '5.jpg'},
      { store_id: 1, name: "鯨魚貼紙", price: 150, quantity: 32, category: '紙類', image: '6.jpg'},
      { store_id: 1, name: "乾燥花貼紙", price: 150, quantity: 43, category: '紙類', image: '7.jpg'},
      { store_id: 1, name: "變色龍紙膠帶", price: 250, quantity: 32, category: '紙類', image: '8.jpg'},
      { store_id: 1, name: "乾燥花紙膠帶", price: 250, quantity: 30, category: '紙類', image: '9.jpg'},
      { store_id: 2, name: "燈泡花器印章", price: 200, quantity: 72, category: '紙類', image: '10.jpg'},
      { store_id: 2, name: "松果橡皮印章", price: 200, quantity: 50, category: '紙類', image: '11.jpg'},
      { store_id: 2, name: "花器紙膠帶", price: 250, quantity: 32, category: '紙類', image: '12.jpg'},
      { store_id: 2, name: "菇百科手工明信片", price: 200, quantity: 43, category: '紙類', image: '13.jpg'},
      { store_id: 2, name: "菇百科明信片", price: 80, quantity: 31, category: '紙類', image: '14.jpg'},
      { store_id: 2, name: "聖誕之星明信片", price: 80, quantity: 12, category: '紙類', image: '15.jpg'},
      { store_id: 2, name: "鯨魚貼紙", price: 90, quantity: 23, category: '紙類', image: '16.jpg'},
      { store_id: 2, name: "春聯客製化", price: 100, quantity: 77, category: '紙類', image: '17.jpg'},
      { store_id: 3, name: "秋實紙膠帶", price: 220, quantity: 33, category: '紙類', image: '18.jpg'},
      { store_id: 3, name: "鄉村花卉印章", price: 250, quantity: 45, category: '紙類', image: '19.jpg'},
      { store_id: 3, name: "墨水瓶花卉貼紙", price: 150, quantity: 56, category: '紙類', image: '20.jpg'},
    ]

    product_list.each{ |product|
      po = Product.new(product) 
      p "#{po} create success" if po.save
    }
    p 'done'
  end
end