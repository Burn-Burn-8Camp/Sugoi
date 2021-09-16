class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id, name, store_name, price)
    found_item = @items.find { |item| item.product_id === product_id }
    if found_item
      found_item.increment!
    else
      @items << CartItem.new(product_id, name, store_name, price)   
    end
  end


  def change_item_quantity(product_id, quantity)
    found_item = @items.find { |item| item.product_id === product_id }
    if found_item
      found_item.changement!(quantity)
    end
  end

  def total
    t = @items.reduce(0) { |acc, item| acc + item.total }
    is_children_day ? t * 0.8 : t
  end

  def empty?
    @items.empty?
  end

  def serialize
    t = @items.map { |item|
      { "product_id" => item.product_id, "name" => item.name, "store" => item.store_name, "price" => item.price, "quantity" => item.quantity }
    }
    { "items" => t }
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["name"], item["store"], item["price"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  private
    def is_children_day
      Time.now.month === 4 && Time.now.day === 4
    end

end