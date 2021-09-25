class Cart
  attr_reader :items, :coupon

  def initialize(items = [], coupon = [])
    @items = items
    @coupon = coupon
  end

  def add_item(product_id, name, store_id, store_name, price)
    found_item = @items.find { |item| item.product_id === product_id }
    if found_item
      found_item.increment!
    else
      @items << CartItem.new(product_id, name, store_id, store_name, price)
    end
  end

  def total
    t = @items.reduce(0) { |acc, item| acc + item.total }
    t = t * 0.8 if is_children_day?
    t
  end

  def store_amount
    store_id_list = @items.map { |item| item.store_id }.uniq.sort
    @store_items = []
    store_id_list.each{ |id|
      @store_items << @items.select{ |item|
        item.store_id === id 
      }
    }
    @store_items.count
  end

  def total_included_delivery_fee
    total = @items.reduce(0) { |acc, item| acc + item.total }
    is_children_day? ? total * 0.8 : total
    delivery_fee = Product.deliveries["貨運 NT$100"] * store_amount
    total += delivery_fee
  end

  def change_item_quantity(product_id, quantity)
    found_item = @items.find { |item| item.product_id === product_id.to_i }
    if found_item
      found_item.changement!(quantity)
    end
  end

  def use_coupon(coupon_id, coupon_value)
    @coupon = []
    @coupon << CartCoupon.new(coupon_id, coupon_value)
    total_included_delivery_fee = self.total_included_delivery_fee - coupon_value.to_i   
  end
  
  def empty?
    @items.empty?
  end

  def serialize
    t = @items.map { |item|
      { "product_id" => item.product_id, "name" => item.name, "store_id" => item.store_id, "store" => item.store_name, "price" => item.price, "quantity" => item.quantity }
    }
    c = @coupon.map { |coupon|
      { "coupon_id" => coupon.coupon_id, "coupon_value" => coupon.coupon_value}
    }
    { "items" => t, "coupon" => c }
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["name"], item["store_id"], item["store"], item["price"], item["quantity"])
      }
      if hash && hash["coupon"]
        coupon = hash["coupon"].map { |coupon|
          CartCoupon.new(coupon["coupon_id"], coupon["coupon_value"])
        }
      end
      Cart.new(items, coupon)
    else
      Cart.new
    end
  end

  private
    def is_children_day?
      Time.now.month === 4 && Time.now.day === 4
    end
end