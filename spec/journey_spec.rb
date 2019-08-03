require 'journey'

describe Journey do

  let(:station) { double :station }
  let(:journey) { Journey.new(station) }

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when finishing a journey' do
    expect(journey.finish). to eq journey
  end

  context 'starting a journey' do
    it 'has an entry station' do
      expect(journey.entry_station).to eq station
    end

    it 'knows if a journey is not complete' do
      expect(journey).not_to be_complete
    end

    it 'returns a penalty fare while journey is incomplete' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

  context 'finishing a journey' do
    before do
      journey.finish(station)
    end

    it 'has an exit station' do
      expect(journey.exit_station).to eq station
    end

    it 'knows if a journey is complete' do
      expect(journey).to be_complete
    end

    it 'returns the example fare when a journey is complete' do
      expect(journey.fare).to eq Journey::EXAMPLE_FARE
    end
  end

end
