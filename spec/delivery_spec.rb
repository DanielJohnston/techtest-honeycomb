require 'delivery'

describe Delivery do
  subject do
    Delivery.new broadcaster, delivery_product
  end

  let(:broadcaster) { double('broadcaster') }
  let(:delivery_product) { double('delivery_product') }

  it 'accepts a broadcaster and delivery product upon creation' do
    expect { subject }.to_not raise_error
  end

  it 'returns the broadcaster given on creation' do
    expect(subject.broadcaster).to eq broadcaster
  end

  it 'returns the delivery product given on creation' do
    expect(subject.delivery_product).to eq delivery_product
  end
end
