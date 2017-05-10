require 'order'

describe Order do
  subject {
    material = double("material")
    order = Order.new material
  }

  describe '#new' do
    it 'accepts a material argument upon creation' do
      expect{ subject }.to_not raise_error
    end
  end

  describe '#add_delivery' do
    it 'accepts a broadcaster and standard delivery method argument' do
      broadcaster = double("broadcaster")
      expect{ subject.add_delivery broadcaster, :standard }.to_not raise_error
    end
  end

  describe '#delivery_list' do
    it 'returns a single delivery that has been passed into an order' do
      broadcaster = double("broadcaster")
      subject.add_delivery broadcaster, :standard
      expect(subject.delivery_list).to eq [{broadcaster: broadcaster, delivery_product: :standard}]
    end

    it 'returns two deliveries that have been passed into an order' do
      broadcaster_1 = double("broadcaster_1")
      broadcaster_2 = double("broadcaster_2")
      subject.add_delivery broadcaster_1, :standard
      subject.add_delivery broadcaster_2, :standard
      expect(subject.delivery_list).to eq [{broadcaster: broadcaster_1, delivery_product: :standard},
      {broadcaster: broadcaster_2, delivery_product: :standard}]
    end
  end

  describe '#subtotal' do
    it 'for a single standard delivery is 10' do
      broadcaster = double("broadcaster")
      subject.add_delivery broadcaster, :standard
      expect(subject.subtotal).to eq 10
    end

    it 'for a single express delivery is 20' do
      broadcaster = double("broadcaster")
      subject.add_delivery broadcaster, :express
      expect(subject.subtotal).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
      broadcaster = double("broadcaster")
      subject.add_delivery broadcaster, :standard
      subject.add_delivery broadcaster, :express
      expect(subject.subtotal).to eq 30
    end

    it 'for five standard deliveries is 50' do
      5.times do |i|
        subject.add_delivery double("broadcaster_" + i.to_s), :standard
      end
      expect(subject.subtotal).to eq 50
    end
  end
end
