require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }
  let(:max_bal) { Oystercard::MAX_BAL }

  describe '#balance' do
    it 'starts with a default balance of 0' do
      expect(card.balance).to eq 0
    end
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

  describe '#deduct' do
    it 'deducts the given amount from the balance' do
      card.top_up(20)
      expect(card.deduct(5)).to eq 15
    end
  end

  describe '#in_journey?' do
    it 'returns true when in journey' do
      card.touch_in
      expect(card.in_journey?).to be true
    end

    it 'returns false when not in journey' do
      card.touch_out
      expect(card.in_journey?).to be false
    end
  end

  describe '#touch_in' do
    it 'sets in journey to true' do
      card.touch_in
      expect(card.in_journey).to be true
    end
  end

  describe '#touch_out' do
    it 'sets in journey to false' do
      card.touch_out
      expect(card.in_journey).to be false   
    end
  end
end
