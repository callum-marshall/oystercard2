require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it 'has an empty list of journeys by default' do
    expect(subject.journey_history).to be_empty
  end

  it 'starts with a default balance of 0' do
    expect(card.balance).to eq 0
  end

  it 'starts not "in journey"' do
    expect(card).not_to be_in_journey
  end

  it 'stores a journey' do
    card.top_up(10)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journey_history).to include journey
  end

end
