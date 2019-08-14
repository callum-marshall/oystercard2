require 'oystercard'
require 'station'

describe 'Features' do

  let(:card) { Oystercard.new(journey_log: JourneyLog.new(journey_class: Journey)) }
  let(:bank) { Station.new(name: "Bank", zone: 1) }
  let(:liverpool_st) { Station.new(name: "Liverpool Street", zone: 1) }
  let(:bethnal_green) { Station.new(name: "Bethnal Green", zone: 2) }
  let(:edgeware) { Station.new(name: "Edgeware", zone: 5) }
  let(:heathrow) { Station.new(name: "Heathrow", zone: 6) }

  context 'having funds on a card' do
    # In order to use public transport
    # As a customer
    # I want money on my card

    it 'has a balance by default' do
      default_balance = Oystercard::DEF_BAL
      expect(card.show_balance).to be default_balance
      expect(card.show_balance).to be_a Integer
    end

    # In order to keep using public transport
    # As a customer
    # I want to add money to my card

    it 'which can be added to' do
      card.top_up(10)
      expect(card.show_balance).to be 10
    end

    # In order to protect my money
    # As a customer
    # I don't want to put too much money on my card

    it 'that does not allow the user to exceed the maximum balance' do
      max_bal = Oystercard::MAX_BAL
      card.top_up(max_bal)
      expect { card.top_up(1) }.to raise_error("You cannot exceed £#{max_bal}")
    end

  end

  context 'paying for a journey' do
    # In order to pay for my journey
    # As a customer
    # I need my fare deducted from my card

    it 'deducts the fare from a card' do
      card.top_up(10)
      card.touch_in(bank)
      expect(card.show_balance).to eq 10
      card.touch_out(liverpool_st)
      expect(card.show_balance).to eq 9
    end

    # In order to get through the barriers
    # As a customer
    # I need to touch in and out

    # In order to pay for my journey
    # As a customer
    # I need to have the minimum amount for a single journey

    it 'requires the user to have the minimum amount for a single journey' do
      expect(card.show_balance).to be < Oystercard::MIN_BAL
      expect { card.touch_in(bank) }.to raise_error("You have insufficient funds")
    end

    # In order to pay for my journey
    # As a customer
    # I need to pay for my journey when it's complete

    it 'deducts the cost of a journey when it is complete' do
      card.top_up(1)
      card.touch_in(bank)
      card.touch_out(heathrow)
      expect(card.show_balance).to eq(-5)
    end

  end

  context 'viewing journey details' do

    # In order to pay for my journey
    # As a customer
    # I need to know where I've travelled from

    it 'stores the station the user touches in at' do
      card.top_up(10)
      card.touch_in(bank)
      expect(card.journey_log.journeys[0].entry_station.name).to eq "Bank"
    end

    # In order to know where I have been
    # As a customer
    # I want to see to all my previous trips

    it 'shows the user all their previous trips' do
      card.top_up(20)
      card.touch_in(bank)
      card.touch_out(bethnal_green)
      card.touch_in(bethnal_green)
      card.touch_out(liverpool_st)
      card.touch_in(liverpool_st)
      card.touch_out(bank)
      expect(card.journey_log.print_journeys).to include "Bank->Bethnal Green"
      expect(card.journey_log.print_journeys).to include "Bethnal Green->Liverpool Street"
      expect(card.journey_log.print_journeys).to include "Liverpool Street->Bank"
    end

    # In order to know how far I have travelled
    # As a customer
    # I want to know what zone a station is in

  end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out

  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated

end
