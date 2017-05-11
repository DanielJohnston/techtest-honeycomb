require 'order'

describe Order do
  subject do
    order = Order.new material, delivery_list
  end

  let(:broadcaster) { double('broadcaster') }
  let(:delivery_list) { double('delivery_list') }
  let(:standard) { double('standard_delivery_product') }
  let(:express) { double('express_delivery_product') }
  let(:material) { double('material') }

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
    it 'accepts a broadcaster and standard delivery method argument' do
      allow(delivery_list).to receive(:add).with(broadcaster, standard)
      expect { subject.add_delivery broadcaster, standard }.to_not raise_error
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
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: standard
                                                        }])
      expect(subject.subtotal).to eq 10
    end

    it 'for a single express delivery is 20' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: express
                                                        }])
      expect(subject.subtotal).to eq 20
    end

    it 'for one each standard and express delivery is 30' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: standard
                                                        }, {
        broadcaster: broadcaster, delivery_product: express
                                                        }])
      expect(subject.subtotal).to eq 30
    end

    it 'for five standard deliveries is 50' do
      allow(delivery_list).to receive(:list).and_return([
        { broadcaster: broadcaster, delivery_product: standard }
      ] * 5)
      expect(subject.subtotal).to eq 50
    end
  end

  # Some of these orders are impossible in real life, but test rules in isolation
  describe '#discount_total' do
    it 'is 3 for a subtotal of 30 with no deliveries' do
      allow(subject).to receive(:subtotal).and_return(30)
      allow(delivery_list).to receive(:list).and_return([])
      allow(delivery_list).to receive(:count).and_return(0)
      expect(subject.discount_total(express)).to eq 3
    end

    it 'is 10 for 2 express deliveries with forced 0 subtotal' do
      allow(subject).to receive(:subtotal).and_return(0)
      allow(delivery_list).to receive(:list).and_return([])
      allow(delivery_list).to receive(:count).with(express).and_return(2)
      expect(subject.discount_total(express)).to eq 10
    end

    it 'is 0 for a single standard delivery' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: express
                                                        }])
      allow(delivery_list).to receive(:count).with(express).and_return(0)
      expect(subject.discount_total(express)).to eq 0
    end

    it 'is 5 for 3 standard and 1 express' do
      allow(delivery_list).to receive(:list).and_return([
        { broadcaster: broadcaster, delivery_product: standard },
        { broadcaster: broadcaster, delivery_product: standard },
        { broadcaster: broadcaster, delivery_product: standard },
        { broadcaster: broadcaster, delivery_product: express }
                                                        ])
      allow(delivery_list).to receive(:count).with(express).and_return(1)
      expect(subject.discount_total(express)).to eq 5
    end

    it 'is 19.50 for 3 express' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: express
      }] * 3)
      allow(delivery_list).to receive(:count).with(express).and_return(3)
      expect(subject.discount_total(express)).to eq 19.5
    end
  end

  describe '#total' do
    it 'is 10 for a single standard delivery' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: standard
                                                        }])
      allow(delivery_list).to receive(:count).with(express).and_return(0)
      expect(subject.total(express)).to eq 10
    end

    it 'is 20 for a single express delivery' do
      allow(delivery_list).to receive(:list).and_return([{
        broadcaster: broadcaster, delivery_product: express
                                                        }])
      allow(delivery_list).to receive(:count).with(express).and_return(1)
      expect(subject.total(express)).to eq 20
    end
  end
end
