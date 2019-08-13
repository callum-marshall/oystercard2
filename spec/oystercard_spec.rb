require 'oystercard'

describe Oystercard do

  let(:journey_log) { double :journey_log, journeys: [], start: journey, finish: journey }
  let(:card) { Oystercard.new(journey_log: journey_log) }
  let(:max_bal) { Oystercard::MAX_BAL }
  let(:def_bal) { Oystercard::DEF_BAL }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey, fare: 1 }

  it 'has an empty list of journeys by default' do
    expect(card.journey_log.journeys).to be_empty
  end

  it 'starts with a default balance' do
    expect(card.get_balance).to eq def_bal
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

  describe '#touch_in' do
    it 'throws an exception if a card has insufficient balance' do
      expect { card.touch_in(entry_station) }.to raise_error("You have insufficient funds")
    end
  end

  describe '#touch_out' do
    it 'deducts the minimum fare' do
      value = 10
      card.top_up(value)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.get_balance).to be (value-journey.fare)
    end
  end
end
