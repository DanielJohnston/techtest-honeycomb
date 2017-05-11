require 'broadcaster'

describe Broadcaster do
  subject do
    Broadcaster.new name
  end

  let(:name) { 'Viacom' }

  it 'accepts a broadcaster name upon creation' do
    expect { subject }.to_not raise_error
  end

  it 'returns the name given on creation' do
    expect(subject.name).to eq name
  end
end
