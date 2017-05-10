require 'order'

describe Order do
  subject {
    material = double("material")
    order = Order.new material
  }

  let(:broadcaster) { double("broadcaster") }

  describe '#new' do
    it 'accepts a material argument upon creation' do
      expect{ subject }.to_not raise_error
    end
  end

  describe '#add_delivery' do
    it 'accepts a broadcaster and standard delivery method argument' do
      expect{ subject.add_delivery broadcaster, :standard }.to_not raise_error
    end
  end

  describe '#delivery_list' do
    it 'returns a single delivery that has been passed into an order' do
      subject.add_delivery broadcaster, :standard
      expect(subject.delivery_list).to eq [{broadcaster: broadcaster, delivery_product: :standard}]
    end

    it 'returns two deliveries that have been passed into an order' do
      broadcaster_2 = double("broadcaster_2")
      subject.add_delivery broadcaster, :standard
      subject.add_delivery broadcaster_2, :standard
      expect(subject.delivery_list).to eq [{broadcaster: broadcaster, delivery_product: :standard},
      {broadcaster: broadcaster_2, delivery_product: :standard}]
    end
  end

  describe '#subtotal' do
    it 'for a single standard delivery is 10' do
      subject.add_delivery broadcaster, :standard
      expect(subject.subtotal).to eq 10
    end

    it 'for a single express delivery is 20' do
      subject.add_delivery broadcaster, :express
      expect(subject.subtotal).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
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

  describe '#discount_total' do
    it 'is 3 for a subtotal of 30 with no express deliveries' do
      allow(subject).to receive(:subtotal).and_return(30)
      expect(subject.discount_total).to eq 3
    end

    # This is an impossible order, but tests a single rule in isolation
    it 'is 10 for 2 express deliveries with forced 0 subtotal' do
      allow(subject).to receive(:subtotal).and_return(0)
      subject.add_delivery broadcaster, :express
      subject.add_delivery double("broadcaster_2"), :express
      expect(subject.discount_total).to eq 10
    end

    it 'is 0 for a single standard delivery' do
      subject.add_delivery broadcaster, :standard
      expect(subject.discount_total).to eq 0
    end

    it 'is 5 for 3 standard and 1 express' do
      subject.add_delivery broadcaster, :standard
      subject.add_delivery double("broadcaster_2"), :standard
      subject.add_delivery double('broadcaster_3'), :standard
      subject.add_delivery double('broadcaster_4'), :express
      expect(subject.discount_total).to eq 5
    end

    it 'is 19.50 for 3 express' do
      subject.add_delivery broadcaster, :express
      subject.add_delivery double("broadcaster_2"), :express
      subject.add_delivery double('broadcaster_3'), :express
      expect(subject.discount_total).to eq 19.5
    end
  end

  describe '#total' do
    it 'is 10 for a single standard delivery' do
      subject.add_delivery broadcaster, :standard
      expect(subject.total).to eq 10
    end

    it 'is 20 for a single express delivery' do
      subject.add_delivery broadcaster, :express
      expect(subject.total).to eq 20
    end
  end
end
