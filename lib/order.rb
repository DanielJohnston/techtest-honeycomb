class Order
  def initialize material, delivery_list = DeliveryList.new
    @material = material
    @delivery_list = delivery_list
  end

  def add_delivery broadcaster, delivery_product
    @delivery_list.add broadcaster, delivery_product
  end

  def delivery_list
    @delivery_list.list
  end

  def subtotal
    delivery_list.reduce(0) { |total, delivery|
      total + delivery[:delivery_product].price
    }
  end

  def discount_total express_delivery_product
    running_subtotal = subtotal
    running_subtotal -= quantity(express_delivery_product) * 5 if quantity(express_delivery_product) >= 2
    running_subtotal *= 0.9 if running_subtotal >= 30
    subtotal - running_subtotal
  end

  def total express_delivery_product
    subtotal - discount_total(express_delivery_product)
  end

  private

  def quantity delivery_product
    delivery_list.count { |delivery|
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
