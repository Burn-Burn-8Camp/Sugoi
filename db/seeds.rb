(1..3).each{ |i| 
  user = User.new
  user.name = "#{i}"
  user.email = "#{i}@gmail.com"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "seller"
  user.save!
  store = Store.new
  store.user_id = i
  store.name = "#{i}-store"
  store.save!
}
