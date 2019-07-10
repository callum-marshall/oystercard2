require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'starts with a default balance of 0' do
      card = Oystercard.new
      expect(card.balance).to eq 0
    end
  end

  describe 'top_up' do
    it 'adds the given amount to the balance' do
      card = Oystercard.new
      card.top_up(10)
      expect(card.balance).to eq 10
    end
  end
end
