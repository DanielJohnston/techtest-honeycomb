Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), '../lib')) + "/**/*.rb"].each do |file|
    require file
end

describe 'Place an order' do
  let(:standard) { DeliveryProduct.new "Standard", 10 }
  let(:express) { DeliveryProduct.new "Express", 20 }

  # Spec example 1: send `WNP/SWCL001/010` to Disney, Discovery, Viacom via
  # Standard Delivery and Horse and Country via Express Delivery, based
  # on the defined Discounts the total should be $45.00
  it '3 standard and 1 express, with discounts totals $45.00' do
    material = Material.new 'WNP/SWCL001/010'
    order = Order.new material, DeliveryList.new
    order.add_delivery Broadcaster.new('Disney'), standard
    order.add_delivery Broadcaster.new('Discovery'), standard
    order.add_delivery Broadcaster.new('Viacom'), standard
    order.add_delivery Broadcaster.new('Horse and Country'), express
    expect(order.total(express)).to eq 45
  end

  # Spec example 2: send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via
  # Express Delivery, based on the defined Discounts the total should be $40.50
  it '3 express, with discounts totals $40.50' do
    material = Material.new 'ZDW/EOWW005/010'
    order = Order.new material, DeliveryList.new
    order.add_delivery Broadcaster.new('Disney'), express
    order.add_delivery Broadcaster.new('Discovery'), express
    order.add_delivery Broadcaster.new('Viacom'), express
    expect(order.total(express)).to eq 40.5
  end
end
