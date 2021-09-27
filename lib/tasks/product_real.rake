namespace :products do
  desc "Generate fake coupons"
  task :real => :environment do
    product_list = [
      { store_id: 1, name: "海洋之心貼紙", price: 90, quantity: 3, category: '紙類', image: 's1.jpg'},
      { store_id: 1, name: "花貼紙", price: 150, quantity: 3, category: '紙類', image: 's2.jpg'},
      { store_id: 1, name: "小狗貼紙", price: 160, quantity: 3, category: '紙類', image: 's3.jpg'},
      { store_id: 1, name: "香草貼紙", price: 100, quantity: 3, category: '紙類', image: 's4.jpg'},
      { store_id: 1, name: "摩托車貼紙", price: 200, quantity: 3, category: '紙類', image: 's5.jpg'},
    ]

    product_list.each{ |product|
      p = Product.new(product)
      p.save      
    }
    p "created 5 poductss"
  end
end