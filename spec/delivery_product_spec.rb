require 'delivery_product'

describe DeliveryProduct do
  subject {
    name = double('name')
    # price = double('price')
    DeliveryProduct.new name, price
  }

  let(:price) { double('price') }

  it 'accepts a product name and price upon creation' do
    expect{ subject }.to_not raise_error
  end

  it 'returns the price given to it' do
    expect(subject.price).to eq price
  end
end
