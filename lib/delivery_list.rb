class DeliveryList
  def initialize
    @delivery_list = []
  end

  def list
    @delivery_list
  end

  def add(broadcaster, delivery_product)
    @delivery_list << { broadcaster: broadcaster, delivery_product: delivery_product }
  end
end
