require 'material'

describe Material do
  it 'accepts a Clock name upon creation' do
    expect{ Material.new 'WNP/SWCL001/010' }.to_not raise_error
  end
end
