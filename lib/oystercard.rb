class Oystercard

  def initialize
    @balance = 0
  end

  attr_reader :balance

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  MAX_BAL = 90

end
