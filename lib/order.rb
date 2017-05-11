class Order
  def initialize(material, delivery_list = DeliveryList.new)
    @material = material
    @delivery_list = delivery_list
  end

  def clock
    @material.clock
  end

  def add_delivery(delivery)
    @delivery_list.add delivery
  end

  def delivery_list
    @delivery_list.list
  end

  def subtotal
    delivery_list.reduce(0) do |total, delivery|
      total + delivery.delivery_product.price
    end
  end

  def discount_total(express_delivery_product)
    running_subtotal = subtotal
    running_subtotal -= @delivery_list.count(express_delivery_product) * 5 if @delivery_list.count(express_delivery_product) >= 2
    running_subtotal *= 0.9 if running_subtotal >= 30
    subtotal - running_subtotal
  end

  def total(express_delivery_product)
    subtotal - discount_total(express_delivery_product)
  end
end
