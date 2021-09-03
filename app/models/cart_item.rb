class CartItem
  attr_reader :product_id, :quantity, :name

  def initialize(product_id, name, quantity = 1)
    @product_id = product_id
    @name = name
    @quantity = quantity
  end

  def increment!(n = 1)
    @quantity += n
  end

  def product
    Product.find(@product_id)
  end

  def total
    @quantity * price
  end

  
  private
  def price ## 將 BigDecimal 轉成數字
    product.price.to_i
  end


end