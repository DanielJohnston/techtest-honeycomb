require 'discount'

describe Discount do
  subject do
    discount = Discount.new discount_strategy
  end

  let(:discount_strategy) { double('discount_strategy') }

  describe '#new' do
    it 'accepts a single discount strategy argument on creation' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#name' do
    it 'returns the name of the strategy being used' do
      name = double('name')
      allow(discount_strategy).to receive(:name).and_return(name)
      expect(subject.name).to eq name
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
end
