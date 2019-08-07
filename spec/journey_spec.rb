require 'journey'

describe Journey do

  let(:station_a) { double :station, zone: 1 }
  let(:station_b) { double :station, zone: 2 }
  let(:journey) { Journey.new(station_a) }
  let(:penalty_fare) { Journey::PENALTY_FARE }

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq penalty_fare
  end

  it 'returns itself when finishing a journey' do
    expect(journey.finish). to eq journey
  end

  context 'starting a journey' do
    it 'has an entry station' do
      expect(journey.entry_station).to eq station_a
    end

    it 'knows if a journey is not complete' do
      expect(journey).not_to be_complete
    end

    it 'returns a penalty fare while journey is incomplete' do
      expect(journey.fare).to eq penalty_fare
    end
  end

  context 'finishing a journey' do
    it 'has an exit station' do
      journey.finish(station_b)
      expect(journey.exit_station).to eq station_b
    end

    it 'knows if a journey is complete' do
      journey.finish(station_b)
      expect(journey).to be_complete
    end
  end

  context 'calculating the fare for a complete journey' do
    let(:station_c) { double :station, zone: 3 }
    let(:station_d) { double :station, zone: 4 }
    let(:station_e) { double :station, zone: 5 }
    let(:station_f) { double :station, zone: 6 }

    it 'from zone 1 to zone 1' do
      journey1 = Journey.new(station_a)
      journey1.finish(station_a)
      expect(journey1.fare).to eq 1
    end

    it 'from zone 2 to zone 1' do
      journey2 = Journey.new(station_b)
      journey2.finish(station_a)
      expect(journey2.fare).to eq 2
    end

    it 'from zone 6 to zone 3' do
      journey3 = Journey.new(station_f)
      journey3.finish(station_c)
      expect(journey3.fare).to eq 4
    end

    it 'from zone 2 to zone 5' do
      journey4 = Journey.new(station_b)
      journey4.finish(station_e)
      expect(journey4.fare).to eq 4
    end

    it 'from zone 4 to zone 6' do
      journey5 = Journey.new(station_d)
      journey5.finish(station_f)
      expect(journey5.fare).to eq 3
    end
  end

end
