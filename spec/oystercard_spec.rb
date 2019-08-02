require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }
  let(:max_bal) { Oystercard::MAX_BAL }
  let(:min_fare) { Oystercard::MIN_FARE }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it 'has an empty list of journeys by default' do
    expect(subject.journey_history).to be_empty
  end

  it 'stores a journey' do
    card.top_up(10)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journey_history).to include journey
  end

  it 'starts with a default balance of 0' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    it 'adds the given amount to the balance' do
      expect(card.top_up(10)).to eq 10
    end

    it 'throws an exception if the new balance exceeds the maximum balance' do
      card.top_up(max_bal)
      expect { card.top_up(1) }.to raise_error("You cannot exceed £#{max_bal}")
    end
  end

  describe '#in_journey?' do
    it 'starts not in journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes in_journey to true' do
      card.top_up(10)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'throws an exception if a card has insufficient balance' do
      expect { card.touch_in(entry_station) }.to raise_error("You have insufficient funds")
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it 'deducts the minimum fare' do
      card.top_up(10)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-5)
    end
  end
end
