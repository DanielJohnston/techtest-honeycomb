require 'discount_strategies/discount_on_total'

describe DiscountOnTotal do
  let(:delivery_list) { double('delivery_list') }
  # let(:running_subtotal) { double('running_subtotal') }

  describe '#new' do
    it 'instantiates without any arguments' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#reduction' do
    describe 'not in July' do
      let(:date_time) { Time.new(2016, 6, 28) }

      it 'is 0 when running_subtotal is 29' do
        expect(subject.reduction(delivery_list, 29, date_time)).to eq 0
      end

      it 'is 3 when running_subtotal is 30' do
        expect(subject.reduction(delivery_list, 30, date_time)).to eq 3
      end

      it 'is 5.5 when running_subtotal is 55' do
        expect(subject.reduction(delivery_list, 55, date_time)).to eq 5.5
      end
    end

    describe 'in July' do
      let(:date_time) { Time.new(2016, 7, 14) }

      it 'is 0 when running_subtotal is 29' do
        expect(subject.reduction(delivery_list, 29, date_time)).to eq 0
      end

      it 'is 3 when running_subtotal is 30' do
        expect(subject.reduction(delivery_list, 30, date_time)).to eq 6
      end

      it 'is 5.5 when running_subtotal is 55' do
        expect(subject.reduction(delivery_list, 55, date_time)).to eq 11
      end
    end
  end
end
