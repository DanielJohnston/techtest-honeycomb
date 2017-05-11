require 'broadcaster'

describe Broadcaster do
  it 'accepts a broadcaster name upon creation' do
    expect { Broadcaster.new 'Viacom' }.to_not raise_error
  end
end
