require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }

  describe '#balance' do
    it 'starts with a default balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe 'top_up' do
    it 'adds the given amount to the balance' do
      card.top_up(10)
      expect(card.balance).to eq 10
    end
  end
end
