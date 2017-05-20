class Discount
  def initialize(discount_strategy)
    @discount_strategy = discount_strategy
  end

  def name
    @discount_strategy.name
  end

  def reduction(delivery_list, running_subtotal, date_time)
    @discount_strategy.reduction delivery_list, running_subtotal, date_time
  end
end
