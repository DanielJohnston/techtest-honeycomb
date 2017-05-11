require 'discount'

describe Discount do
  subject do
    discount = Discount.new discount_strategy
  end

  let(:discount_strategy) { double('discount_strategy') }

  describe '#new' do
    it 'accepts a single discount strategy argument on creation' do
      expect{ subject }.to_not raise_error
    end
  end

  describe '#applies?' do
    it 'returns true if the strategy returns true' do
      delivery_list = double('delivery_list')
      running_subtotal = double('running_subtotal')
      allow(discount_strategy).to receive(:applies?).with(delivery_list, running_subtotal).and_return(true)
      expect(subject.applies?(delivery_list, running_subtotal)).to be true
    end
  end

  describe '#reduction' do
    it 'passes through the strategy result' do
      delivery_list = double('delivery_list')
      running_subtotal = double('running_subtotal')
      result = double('result')
      allow(discount_strategy).to receive(:reduction).with(delivery_list, running_subtotal).and_return(result)
      expect(subject.reduction(delivery_list, running_subtotal)).to eq result
    end
  end

  describe '#set_express' do
    xit 'accepts a delivery_product' do
      express_delivery_product = double('express_delivery_product')
      expect{ subject.set_express(express_delivery_product) }.to_not raise_error
    end
  end

  describe '#discount_total' do
    describe 'with #set_express not having been set' do
      xit 'raises an error' do
        delivery_list = double('delivery_list')
        subtotal = double('subtotal')
        expect{ subject.discount_total(delivery_list, subtotal) }.to raise_error('First define the express delivery product using #set_express')
      end
    end

    describe 'with #set_express set' do
      let(:standard) { double('standard_delivery_product') }
      let(:express) { double('express_delivery_product') }
      let(:delivery_list) { double('delivery_list') }

      before(:each) do
        subject.set_express express
      end

      xit 'is 3 for a subtotal of 30 with no deliveries' do
        allow(delivery_list).to receive(:list).and_return([])
        allow(delivery_list).to receive(:count).and_return(0)
        expect(subject.discount_total(delivery_list, 30)).to eq 3
      end

      xit 'is 10 for 2 express deliveries with forced 0 subtotal' do
        allow(delivery_list).to receive(:list).and_return([])
        allow(delivery_list).to receive(:count).with(express).and_return(2)
        expect(subject.discount_total(delivery_list, 0)).to eq 10
      end

      xit 'is 0 for a single standard delivery' do
        delivery = double('delivery')
        allow(delivery_list).to receive(:list).and_return([delivery])
        allow(delivery_list).to receive(:count).and_return(1)
        allow(delivery).to receive(:delivery_product).and_return(standard)
        expect(subject.discount_total(delivery_list, 10)).to eq 0
      end

      xit 'is 5 for 3 standard and 1 express' do
        delivery = double('delivery')
        delivery_2 = double('delivery_2')
        allow(delivery_list).to receive(:list).and_return([delivery, delivery, delivery_2, delivery])
        allow(delivery).to receive(:delivery_product).and_return(standard)
        allow(delivery_2).to receive(:delivery_product).and_return(express)
        allow(delivery_list).to receive(:count).with(express).and_return(1)
        expect(subject.discount_total(delivery_list, 50)).to eq 5
      end

      xit 'is 19.50 for 3 express' do
        delivery = double('delivery')
        allow(delivery_list).to receive(:list).and_return([delivery] * 3)
        allow(delivery_list).to receive(:count).with(express).and_return(3)
        allow(delivery).to receive(:delivery_product).and_return(express)
        expect(subject.discount_total(delivery_list, 60)).to eq 19.5
      end
    end
  end
end
