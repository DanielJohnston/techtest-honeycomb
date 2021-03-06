class Order
  def initialize(material, discount_list, delivery_list = DeliveryList.new, date_time=Time.now)
    @material = material
    @discount_list = discount_list
    @delivery_list = delivery_list
    @date_time = date_time
  end

  def date_time
    @date_time
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
    self.delivery_list.reduce(0) do |total, delivery|
      total + delivery.delivery_product.price
    end
  end

  # def order_lines
  #   lines = []
  #   delivery_list.each do |delivery|
  #     lines << {broadcaster_name: delivery.broadcaster.name, delivery_product_name: delivery.delivery_product.name, price: delivery.delivery_product.price}
  #   end
  #   lines
  # end

  def discount_list
    @discount_list.list
  end

  def discount_lines(return_total: false)
    lines = []
    running_subtotal = self.subtotal
    self.discount_list.each do |discount|
      reduction = discount.reduction(@delivery_list, running_subtotal, @date_time)
      next unless reduction > 0
      running_subtotal -= reduction
      lines << { name: discount.name, reduction: reduction, subtotal: running_subtotal }
    end
    return running_subtotal if return_total
    lines
  end

  def total
    self.discount_lines(return_total: true)
  end
end
