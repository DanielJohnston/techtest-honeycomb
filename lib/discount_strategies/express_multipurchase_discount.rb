class ExpressMultipurchaseDiscount
  def initialize(express_delivery_product)
    @express_delivery_product = express_delivery_product
  end

  def name
    'Express delivery costs $5 less per delivery if you send 2 or more materials'
  end

  def reduction(delivery_list, _running_subtotal, date_time)
    if delivery_list.count(@express_delivery_product) >= 2
      delivery_list.count(@express_delivery_product) * 5
    else
      0
    end
  end
end
