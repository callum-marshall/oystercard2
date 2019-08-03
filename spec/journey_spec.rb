require 'journey'

describe Journey do

  let(:station) { double :station }
  let(:journey) { Journey.new(station) }

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq 6
  end

  context 'starting a journey' do
    it 'has an entry station' do
      expect(journey.entry_station).to eq station
    end
  end

  context 'finishing a journey' do
    it 'returns itself when exiting a journey' do
      expect(journey.finish(station)). to eq journey
    end

    it 'has an exit station' do
      journey.finish(station)
      expect(journey.exit_station).to eq station
    end
  end

end
