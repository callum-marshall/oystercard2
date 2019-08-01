class Oystercard

  DEF_BAL = 0
  MIN_BAL = 1
  MAX_BAL = 90
  MIN_FARE = 5

  attr_reader :balance, :journey_history

  def initialize
    @balance = DEF_BAL
    @journey = {}
    @journey_history = []
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in(entry_station)
    raise("You have insufficient funds") if @balance < MIN_BAL
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey[:exit_station] = exit_station
    @journey_history << @journey
  end

  def in_journey?
    @journey[:entry_station] != nil && @journey[:exit_station] == nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
