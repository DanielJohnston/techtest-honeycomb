require 'delivery_list'

describe DeliveryList do
  let(:delivery) { double('delivery') }

  describe '#list' do
    it 'is initially empty' do
      expect(subject.list).to eq []
    end

    it 'returns a single delivery that has been passed into a list' do
      subject.add delivery
      expect(subject.list).to eq [delivery]
    end

    it 'returns two deliveries that have been passed into an order' do
      delivery_2 = double('delivery_2')
      subject.add delivery
      subject.add delivery_2
      expect(subject.list).to eq [delivery, delivery_2]
    end
  end

  describe '#add' do
    it 'accepts a delivery argument' do
      expect { subject.add delivery }.to_not raise_error
    end
  end

  describe '#count' do
    it 'counts 3 of a specified delivery_product and not 2 others' do
      delivery_product_1 = double('delivery_product_1')
      delivery_product_2 = double('delivery_product_2')
      5.times { subject.add delivery }
      allow(delivery).to receive(:delivery_product).and_return(delivery_product_1,
      delivery_product_1, delivery_product_2, delivery_product_2, delivery_product_2)
      expect(subject.count(delivery_product_2)).to eq 3
    end

    it 'returns 0 for an empty delivery list' do
      delivery_product = double('delivery_product')
      expect(subject.count(delivery_product)).to eq 0
    end
  end
end
