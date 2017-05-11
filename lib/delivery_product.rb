class DeliveryProduct
  def initialize(name, price)
    @name = name
    @price = price
  end

  attr_reader :price
end
