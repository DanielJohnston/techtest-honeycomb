require 'order'

describe Order do
  describe '#new' do
    it 'accepts a material argument upon creation' do
      material = double("material")
      expect{ Order.new material }.to_not raise_error
    end
  end

  describe '#add_delivery' do
    it 'accepts a broadcaster and standard delivery method argument' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      expect{ order.add_delivery broadcaster, :standard }.to_not raise_error
    end
  end

  describe '#delivery_list' do
    it 'returns a single delivery that has been passed into an order' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :standard
      expect(order.delivery_list).to eq [{broadcaster: broadcaster, delivery_product: :standard}]
    end

    it 'returns two deliveries that have been passed into an order' do
      material = double("material")
      order = Order.new material
      broadcaster_1 = double("broadcaster_1")
      broadcaster_2 = double("broadcaster_2")
      order.add_delivery broadcaster_1, :standard
      order.add_delivery broadcaster_2, :standard
      expect(order.delivery_list).to eq [{broadcaster: broadcaster_1, delivery_product: :standard},
      {broadcaster: broadcaster_2, delivery_product: :standard}]
    end
  end

  describe '#subtotal' do
    it 'for a single standard delivery is 10' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :standard
      expect(order.subtotal).to eq 10
    end

    it 'for a single express delivery is 20' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :express
      expect(order.subtotal).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :standard
      order.add_delivery broadcaster, :express
      expect(order.subtotal).to eq 30
    end

    it 'for five standard deliveries is 50' do
      material = double("material")
      order = Order.new material
      5.times do |i|
        order.add_delivery double("broadcaster_" + i.to_s), :standard
      end
      expect(order.subtotal).to eq 50
    end
  end
end
