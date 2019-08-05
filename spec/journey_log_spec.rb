require 'journey_log'

describe JourneyLog do

  let(:journey) { double :journey }
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  let(:journey_log) { JourneyLog.new(journey_class: journey_class) }

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      journey_log.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      journey_log.start(station)
      expect(journey_log.journeys).to include journey
    end
  end
end
