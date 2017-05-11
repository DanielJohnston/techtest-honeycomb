require 'material'

describe Material do
  subject do
    Material.new clock
  end

  let(:clock) { 'WNP/SWCL001/010' }

  it 'accepts a Clock code upon creation' do
    expect { subject }.to_not raise_error
  end

  it 'returns the Clock code it was created with' do
    expect(subject.clock).to eq clock
  end
end
