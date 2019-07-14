class Oystercard

  MAX_BAL = 90
  MIN_BAL = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise("You have insufficient funds") if @balance < MIN_BAL
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
