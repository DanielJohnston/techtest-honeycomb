require 'order'

describe Order do
  subject do
    order = Order.new material, discount_list, delivery_list
  end

  let(:material) { double('material') }
  let(:discount_list) { double('discount_list') }
  let(:delivery_list) { double('delivery_list') }
  let(:delivery) { double('delivery') }
  let(:standard) { double('standard_delivery_product') }
  let(:express) { double('express_delivery_product') }

  before(:each) do
    allow(standard).to receive(:price).and_return(10)
    allow(express).to receive(:price).and_return(20)
  end

  describe '#new' do
    it 'accepts material and delivery list arguments upon creation' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#clock' do
    it 'returns the clock value of the material being delivered' do
      allow(material).to receive(:clock).and_return('WNP/SWCL001/010')
      expect(subject.clock).to eq 'WNP/SWCL001/010'
    end
  end

  describe '#add_delivery' do
    it 'accepts a delivery argument' do
      allow(delivery_list).to receive(:add).with(delivery)
      expect { subject.add_delivery delivery }.to_not raise_error
    end
  end

  describe '#delivery_list' do
    it 'returns a delivery list that has been passed into an order' do
      allow(delivery_list).to receive(:list).and_return(delivery_list)
      expect(subject.delivery_list).to eq delivery_list
    end
  end

  describe '#subtotal' do
    it 'for a single standard delivery is 10' do
      allow(delivery_list).to receive(:list).and_return([delivery])
      allow(delivery).to receive(:delivery_product).and_return(standard)
      expect(subject.subtotal).to eq 10
    end

    it 'for a single express delivery is 20' do
      allow(delivery_list).to receive(:list).and_return([delivery])
      allow(delivery).to receive(:delivery_product).and_return(express)
      expect(subject.subtotal).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
      delivery_2 = double('delivery_2')
      allow(delivery_list).to receive(:list).and_return([delivery, delivery_2])
      allow(delivery).to receive(:delivery_product).and_return(standard)
      allow(delivery_2).to receive(:delivery_product).and_return(express)
      expect(subject.subtotal).to eq 30
    end

    it 'for five standard deliveries is 50' do
      allow(delivery_list).to receive(:list).and_return([delivery] * 5)
      allow(delivery).to receive(:delivery_product).and_return(standard)
      expect(subject.subtotal).to eq 50
    end
  end

  describe '#discount_list' do
    it 'returns a discount_list that has been passed into an order' do
      allow(discount_list).to receive(:list).and_return(discount_list)
      expect(subject.discount_list).to eq discount_list
    end
  end

  describe '#total' do
    let(:discount) { double('discount') }

    it 'is 10 for a single standard delivery with no discount' do
      allow(delivery_list).to receive(:list).and_return([delivery])
      allow(delivery_list).to receive(:count).with(express).and_return(0)
      allow(delivery).to receive(:delivery_product).and_return(standard)
      allow(discount_list).to receive(:list).and_return([discount])
      allow(discount).to receive(:applies?).with(delivery_list, 10).and_return(false)
      expect(subject.total).to eq 10
    end

    it 'is 20 for a single express delivery with no discount' do
      allow(delivery_list).to receive(:list).and_return([delivery])
      allow(delivery_list).to receive(:count).with(express).and_return(1)
      allow(delivery).to receive(:delivery_product).and_return(express)
      allow(discount_list).to receive(:list).and_return([discount])
      allow(discount).to receive(:applies?).with(delivery_list, 20).and_return(false)
      expect(subject.total).to eq 20
    end

    it 'is 40.50 for 3 express with 19.50 discount' do
      name = double('name')
      allow(delivery_list).to receive(:list).and_return([delivery] * 3)
      allow(delivery_list).to receive(:count).with(express).and_return(3)
      allow(delivery).to receive(:delivery_product).and_return(express)
      allow(discount_list).to receive(:list).and_return([discount])
      allow(discount).to receive(:name).and_return(name)
      allow(discount).to receive(:applies?).with(delivery_list, 60).and_return(true)
      allow(discount).to receive(:reduction).with(any_args).and_return(19.5)
      expect(subject.total).to eq 40.5
    end
  end
end
