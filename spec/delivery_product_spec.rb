require 'delivery_product'

describe DeliveryProduct do
  subject do
    DeliveryProduct.new name, price
  end

  let(:price) { double('price') }
  let(:name) { double('name') }

  it 'accepts a product name and price upon creation' do
    expect { subject }.to_not raise_error
  end

  it 'returns the price given to it' do
    expect(subject.price).to eq price
  end

  it 'returns the name given to it' do
    expect(subject.name).to eq name
  end
end
