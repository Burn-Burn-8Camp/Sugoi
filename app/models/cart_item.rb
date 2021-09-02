class CartItem
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity = 1)
    @product_id = product_id
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