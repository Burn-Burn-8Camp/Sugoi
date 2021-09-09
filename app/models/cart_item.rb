class CartItem
  attr_reader :product_id, :quantity, :name, :store_name, :price

  def initialize(product_id, name, store_name, price, quantity = 1)
    @product_id = product_id
    @name = name
    @store_name = store_name
    @price = price
    @quantity = quantity
  end

  def increment!(n = 1)
    @quantity += n
  end

  def store
    Product.find(@product_id).store
  end

  def total
    @quantity * @price.to_i
  end

end