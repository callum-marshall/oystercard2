class Oystercard

  DEF_BAL = 0
  MIN_BAL = 1
  MAX_BAL = 90
  MIN_FARE = 5

  attr_reader :balance, :journeys

  def initialize
    @balance = DEF_BAL
    @journeys = {}
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in(entry_station)
    raise("You have insufficient funds") if @balance < MIN_BAL
    @journeys[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journeys[:exit_station] = exit_station
  end

  def in_journey?
    @journeys[:entry_station] != nil && @journeys[:exit_station] == nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
