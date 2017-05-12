class Delivery
  def initialize(broadcaster, delivery_product)
    @broadcaster = broadcaster
    @delivery_product = delivery_product
  end

  attr_reader :broadcaster, :delivery_product
end
