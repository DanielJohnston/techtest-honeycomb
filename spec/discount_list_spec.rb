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
    it 'accepts a discount argument' do
      expect { subject.add discount }.to_not raise_error
    end
  end

  # describe '#active_discounts' do
  #   it 'returns 2 active discounts and not 2 inactive ones, in the order entered' do
  #     discount_2 = double('discount_2')
  #     discount_3 = double('discount_3')
  #     discount_4 = double('discount_4')
  #     subject.add discount
  #     subject.add discount_2
  #     subject.add discount_3
  #     subject.add discount_4
  #     allow(discount).to receive(:applies?).and_return(false)
  #     allow(discount_2).to receive(:applies?).and_return(true)
  #     allow(discount_3).to receive(:applies?).and_return(false)
  #     allow(discount_4).to receive(:applies?).and_return(true)
  #     expect(subject.active_discounts).to eq [discount_2, discount_4]
  #   end
  # end
end
