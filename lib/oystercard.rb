class Oystercard

  MAX_BAL = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
