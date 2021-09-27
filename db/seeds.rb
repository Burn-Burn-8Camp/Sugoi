user_list = [
  { name: '阿華', email: 'hua@gmail.com', store: '阿華的店', introduction: '優質又便宜的店'},
  { name: '大明', email: 'min@gmail.com', store: '大明的店', introduction: '市面看不到的優質商店'},
  { name: '小美', email: 'may@gmail.com', store: '小美的店', introduction: '賣一些飾品配件'},
]

user_list.each{ |u, index| 
  user = User.new
  user.name = u[:name]
  user.email = u[:email]
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "seller"
  user.save!
  store = Store.new
  store.user_id = user.id
  store.name = u[:store]
  store.introduction = u[:introduction]
  store.save!
}
p 'done'

