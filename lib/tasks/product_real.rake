namespace :products do
  desc "Generate fake coupons"
  task :real => :environment do
    product_list = [
      { store_id: 1, name: "海洋之心貼紙", price: 90, quantity: 7, category: '紙類', image: '1.jpg'},
      { store_id: 1, name: "花貼紙", price: 150, quantity: 8, category: '紙類', image: '2.jpg'},
      { store_id: 1, name: "小狗貼紙", price: 160, quantity: 2, category: '紙類', image: '3.jpg'},
      { store_id: 1, name: "小貓貼紙", price: 180, quantity: 10, category: '紙類', image: '4.jpg'},
      { store_id: 1, name: "小豬貼紙", price: 200, quantity: 30, category: '紙類', image: '5.jpg'},
      { store_id: 1, name: "鯊魚貼紙", price: 250, quantity: 32, category: '紙類', image: '6.jpg'},
      { store_id: 1, name: "玫瑰貼紙", price: 300, quantity: 43, category: '紙類', image: '7.jpg'},
      { store_id: 1, name: "鮭魚貼紙", price: 50, quantity: 32, category: '紙類', image: '8.jpg'},
      { store_id: 1, name: "熊貓貼紙", price: 60, quantity: 30, category: '紙類', image: '9.jpg'},
      { store_id: 2, name: "摩托車貼紙", price: 80, quantity: 72, category: '紙類', image: '10.jpg'},
      { store_id: 2, name: "跑車貼紙", price: 70, quantity: 50, category: '紙類', image: '11.jpg'},
      { store_id: 2, name: "鬱金香貼紙", price: 20, quantity: 32, category: '紙類', image: '12.jpg'},
      { store_id: 2, name: "大樓貼紙", price: 30, quantity: 43, category: '紙類', image: '13.jpg'},
      { store_id: 2, name: "大象貼紙", price: 40, quantity: 31, category: '紙類', image: '14.jpg'},
      { store_id: 2, name: "鮪魚貼紙", price: 10, quantity: 12, category: '紙類', image: '15.jpg'},
      { store_id: 2, name: "鯨魚貼紙", price: 50, quantity: 23, category: '紙類', image: '16.jpg'},
      { store_id: 2, name: "鱷魚貼紙", price: 29, quantity: 77, category: '紙類', image: '17.jpg'},
      { store_id: 3, name: "行人貼紙", price: 39, quantity: 33, category: '紙類', image: '18.jpg'},
      { store_id: 3, name: "公車貼紙", price: 22, quantity: 45, category: '紙類', image: '19.jpg'},
      { store_id: 3, name: "長頸鹿貼紙", price: 23, quantity: 56, category: '紙類', image: '20.jpg'},
    ]

    product_list.each{ |product|
      p = Product.new(product)
      p.save      
    }
    p "created 20 poductss"
  end
end