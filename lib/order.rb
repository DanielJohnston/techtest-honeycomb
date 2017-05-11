class Order
  def initialize(material, discount, delivery_list = DeliveryList.new)
    @material = material
    @discount = discount
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

  def total
    subtotal - @discount.discount_total(@delivery_list, subtotal)
  end
end
