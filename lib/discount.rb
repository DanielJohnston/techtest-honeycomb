class Discount
 def initialize
   @express_delivery_product = nil
   irb
 end

 def set_express express_delivery_product
   @express_delivery_product = express_delivery_product
 end

 def discount_total delivery_list, subtotal
   raise 'First define the express delivery product using #set_express' unless @express_delivery_product
   running_subtotal = subtotal
   running_subtotal -= delivery_list.count(@express_delivery_product) * 5 if delivery_list.count(@express_delivery_product) >= 2
   running_subtotal *= 0.9 if running_subtotal >= 30
   subtotal - running_subtotal
 end
end
