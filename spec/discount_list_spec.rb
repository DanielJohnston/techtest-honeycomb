require 'discount_list'

describe DiscountList do
  let(:discount) { double('discount') }

  it 'takes no arguments' do
    expect{ subject }.to_not raise_error
  end

  describe '#list' do
    it 'is initially empty' do
      expect(subject.list).to eq []
    end

    it 'returns a single discount that has been passed into a list' do
      subject.add discount
      expect(subject.list).to eq [discount]
    end

    it 'returns two discounts that have been passed into an order, in the order passed in' do
      discount_2 = double('discount_2')
      subject.add discount
      subject.add discount_2
      expect(subject.list).to eq [discount, discount_2]
    end
  end

  describe '#add' do
    it 'accepts an argument containing a discount' do
      expect { subject.add discount }.to_not raise_error
    end
  end
end
