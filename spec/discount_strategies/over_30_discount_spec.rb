require 'discount_strategies/over_30_discount'

describe Over30Discount do
  let(:delivery_list) { double('delivery_list') }
  let(:running_subtotal) { double('running_subtotal') }

  describe '#new' do
    it 'instantiates without any arguments' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#applies?' do
    it 'does not apply when running_subtotal is 29' do
      expect(subject.applies?(delivery_list, 29)).to be false
    end

    it 'does apply when running_subtotal is 30' do
      expect(subject.applies?(delivery_list, 30)).to be true
    end

    it 'does apply when running_subtotal is 50' do
      expect(subject.applies?(delivery_list, 50)).to be true
    end
  end

  describe '#reduction' do
    it 'is 3 when running_subtotal is 30' do
      expect(subject.reduction(delivery_list, 30)).to eq 3
    end

    it 'is 5.5 when running_subtotal is 55' do
      expect(subject.reduction(delivery_list, 55)).to eq 5.5
    end
  end
end
