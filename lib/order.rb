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

  def total
    @delivery_list.inject(0) { |total, delivery|
      price delivery[:delivery_product]
    }
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
