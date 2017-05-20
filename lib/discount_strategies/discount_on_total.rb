class DiscountOnTotal
  def name
    'Spend over $30 to get 10% off'
  end

  def reduction(delivery_list, running_subtotal, date_time)
    if running_subtotal >= 30
      if date_time.month == 7
        running_subtotal * 0.2
      else
        running_subtotal * 0.1
      end
    else
      0
    end
  end
end
