class ExpressMultipurchaseDiscount
  def initialize express_delivery_product
    @express_delivery_product = express_delivery_product
  end

  def applies? delivery_list, running_subtotal
    delivery_list.count(@express_delivery_product) >= 2
  end

  def reduction delivery_list, running_subtotal
    delivery_list.count(@express_delivery_product) * 5
  end
end
