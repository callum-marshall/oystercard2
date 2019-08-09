require 'journey_log'

describe JourneyLog do

  let(:journey) { double :journey }
  let(:station_a) { double :station }
  let(:station_b) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  let(:journey_log) { JourneyLog.new(journey_class: journey_class) }

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(station_a)
      journey_log.start(station_a)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      journey_log.start(station_a)
      expect(journey_log.journeys).to include journey
    end
  end

  describe '#finish' do
    before do
      allow(journey).to receive(:finish).with(station_b).and_return(journey)
    end

    describe 'journey has been started' do
      before do
        journey_log.start(station_a)
      end

      it 'finishes a journey' do
        expect(journey).to receive(:finish).with(station_b)
        journey_log.finish(station_b)
      end

      it 'returns the journey object' do
        expect(journey_log.finish(station_b)).to eq journey
      end
    end

    describe 'journey has not been started' do
      it 'starts a new journey' do
        expect(journey_class).to receive(:new).and_return(journey)
        journey_log.finish(station_b)
      end

      it 'stores the journey' do
        journey_log.finish(station_b)
        expect(journey_log.journeys).to include(journey)
      end
    end
  end
end
