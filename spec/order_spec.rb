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
  end

  describe '#total' do
    it 'for a single standard delivery is 10' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :standard
      expect(order.total).to eq 10
    end

    it 'for a single express delivery is 20' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :express
      expect(order.total).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
      material = double("material")
      order = Order.new material
      broadcaster = double("broadcaster")
      order.add_delivery broadcaster, :standard
      order.add_delivery broadcaster, :express
      expect(order.total).to eq 30
    end
  end
end
