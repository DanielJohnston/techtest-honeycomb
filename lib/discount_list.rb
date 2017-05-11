class DiscountList
  def initialize
    @discount_list = []
  end

  def list
    @discount_list
  end

  def add(discount)
    @discount_list << discount
  end

  # def active_discounts
  #   @discount_list.select { |discount| discount.applies? delivery_list, running_subtotal }
  # end
end
