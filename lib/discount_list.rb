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
end
