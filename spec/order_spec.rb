require 'order'

describe Order do
  it 'accepts a material argument upon creation' do
    material = double("material")
    expect{ Order.new material }.to_not raise_error
  end
end
