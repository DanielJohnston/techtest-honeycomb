class DeliveryList
  def initialize
    @delivery_list = []
  end

  def list
    @delivery_list
  end

  def add(delivery)
    @delivery_list << delivery
  end

  def count(delivery_product)
    self.list.count do |delivery|
      delivery.delivery_product == delivery_product
    end
  end
end
