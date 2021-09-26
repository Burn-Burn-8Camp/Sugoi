class CartItem
  attr_reader :product_id, :name, :store_id, :store_name, :price, :quantity

  def initialize(product_id, name, store_id, store_name, price, quantity = 1)
    @product_id = product_id
    @name = name
    @store_id = store_id
    @store_name = store_name
    @price = price
    @quantity = quantity
  end

  def increment!(n = 1)
    @quantity += n
  end

  def changement!(n)
    @quantity = n.to_i
  end

  def product     
    Product.friendly.find(@product_id)
  end
  
  def store
    Product.friendly.find(@product_id).store
  end

  def total
    @quantity * @price.to_i
  end

end