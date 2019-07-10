require 'oystercard'

describe Oystercard do

  describe 'balance' do
    it 'starts with a default balance of 0' do
      card = Oystercard.new
      expect(card.balance).to eq 0
    end
  end
end
