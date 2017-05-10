class Order
  def initialize material
    @material = material
    @delivery_list = []
  end

  def add_delivery broadcaster, delivery_product
    @delivery_list << {broadcaster: broadcaster, delivery_product: delivery_product}
  end

  def delivery_list
    @delivery_list
  end

  def subtotal
    @delivery_list.inject(0) { |total, delivery|
      total + price(delivery[:delivery_product])
    }
  end

  def total
    subtotal
  end

  private

  def price delivery_product
    case delivery_product
    when :standard
      10
    when :express
      20
    end
  end
end
