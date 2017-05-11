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

  def count(delivery_product)
    list.count do |delivery|
      delivery[:delivery_product] == delivery_product
    end
  end
end
