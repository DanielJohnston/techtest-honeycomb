class Discount
  def initialize(discount_strategy)
    @discount_strategy = discount_strategy
  end

  def name
    @discount_strategy.name
  end

  def applies?(delivery_list, running_subtotal)
    @discount_strategy.applies? delivery_list, running_subtotal
  end

  def reduction(delivery_list, running_subtotal)
    @discount_strategy.reduction delivery_list, running_subtotal
  end
end
