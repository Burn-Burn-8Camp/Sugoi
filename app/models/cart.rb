class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(id, name, store_name)
    found_item = @items.find { |item| item.product_id === id.to_i }
    if found_item
      found_item.increment!
    else
      @items << CartItem.new(id, name, store_name)   
    end
  end

  def total
    t = @items.reduce(0) { |acc, item| acc + item.total }
    t = t * 0.8 if is_children_day?
    t
  end

  def empty?
    @items.empty?
  end

  def serialize
    t = @items.map { |item|
      { "product_id" => item.product.id, "name" => item.name, "store" => item.store_name, "quantity" => item.quantity }
    }
    { "items" => t }
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["name"], item["store"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  private
  def is_children_day?
    Time.now.month === 4 && Time.now.day === 4
  end


end