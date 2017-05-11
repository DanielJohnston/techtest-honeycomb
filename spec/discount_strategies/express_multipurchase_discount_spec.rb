require 'discount_strategies/express_multipurchase_discount'

describe ExpressMultipurchaseDiscount do
  subject do
    ExpressMultipurchaseDiscount.new express_delivery_product
  end

  let(:express_delivery_product) { double('express_delivery_product') }
  let(:running_subtotal) { double('running_subtotal') }

  describe '#new' do
    it 'accepts an express_delivery_product' do
      expect{ subject }.to_not raise_error
    end

    it 'raises an error if an express_delivery_product is not supplied' do
      expect{ ExpressMultipurchaseDiscount.new }.to raise_error(ArgumentError)
    end
  end

  describe '#applies?' do
    it 'does not apply when delivery_list contains 0 express_delivery_product' do
      delivery_list = double('delivery_list')
      allow(delivery_list).to receive(:count).with(express_delivery_product).and_return(0)
      expect(subject.applies?(delivery_list, running_subtotal)).to be false
    end

    it 'does not apply when delivery_list contains 1 express_delivery_product' do
      delivery_list = double('delivery_list')
      allow(delivery_list).to receive(:count).with(express_delivery_product).and_return(1)
      expect(subject.applies?(delivery_list, running_subtotal)).to be false
    end

    it 'applies when delivery_list contains 2 express_delivery_product' do
      delivery_list = double('delivery_list')
      allow(delivery_list).to receive(:count).with(express_delivery_product).and_return(2)
      expect(subject.applies?(delivery_list, running_subtotal)).to be true
    end
  end

  describe '#reduction' do
    it 'is 10 for 2 express_delivery_product' do
      delivery_list = double('delivery_list')
      allow(delivery_list).to receive(:count).with(express_delivery_product).and_return(2)
      expect(subject.reduction(delivery_list, running_subtotal)).to eq 10
    end

    it 'is 25 for 5 express_delivery_product' do
      delivery_list = double('delivery_list')
      allow(delivery_list).to receive(:count).with(express_delivery_product).and_return(5)
      expect(subject.reduction(delivery_list, running_subtotal)).to eq 25
    end
  end
end
