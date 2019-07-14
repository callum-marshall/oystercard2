class Oystercard

  DEF_BAL = 0
  MIN_BAL = 1
  MAX_BAL = 90
  MIN_FARE = 5

  attr_reader :balance

  def initialize
    @balance = DEF_BAL
    @in_journey = false
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in
    raise("You have insufficient funds") if @balance < MIN_BAL
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
