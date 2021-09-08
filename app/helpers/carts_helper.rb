module CartsHelper
  def product_storage(id)
    Product.find(id).quantity
  end
end