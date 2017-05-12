class Over30Discount
  def applies? delivery_list, running_subtotal
    running_subtotal >= 30
  end

  def name
    'Spend over $30 to get 10% off'
  end

  def reduction delivery_list, running_subtotal
    running_subtotal * 0.1
  end
end
