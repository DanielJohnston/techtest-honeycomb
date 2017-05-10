class Order
  def initialize material
    @material = material
    @delivery_list = []
  end

  def add_delivery broadcaster, delivery_product
    @delivery_list << {broadcaster: broadcaster, delivery_product: delivery_product}
  end

  def delivery_list
    @delivery_list
  end

  def subtotal
    @delivery_list.inject(0) { |total, delivery|
      total + price(delivery[:delivery_product])
    }
  end

  def discount_total
    running_subtotal = subtotal
    running_subtotal -= quantity(:express) * 5 if quantity(:express) >= 2
    running_subtotal *= 0.9 if running_subtotal >= 30
    subtotal - running_subtotal
  end

  def total
    subtotal - discount_total
  end

  private

  def quantity delivery_product
    @delivery_list.count { |delivery|
        delivery[:delivery_product] == delivery_product
    }
  end

  def price delivery_product
    case delivery_product
    when :standard
      10
    when :express
      20
    end
  end
end
