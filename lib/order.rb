class Order
  def initialize(material, discount_list, delivery_list = DeliveryList.new)
    @material = material
    @discount_list = discount_list
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

  # def order_lines
  #   lines = []
  #   delivery_list.each do |delivery|
  #     lines << delivery
  #   end
  #   lines
  # end

  def discount_list
    @discount_list.list
  end

  def discount_lines return_total: false
    lines = []
    running_subtotal = subtotal
    discount_list.each do |discount|
      if discount.applies?(@delivery_list, running_subtotal)
        reduction = discount.reduction(@delivery_list, running_subtotal)
        running_subtotal -= reduction
        lines << {name: discount.name, reduction: reduction, subtotal: running_subtotal}
      else
      end
    end
    return running_subtotal if return_total
    lines
  end

  def total
    discount_lines(return_total:true)
  end
end
