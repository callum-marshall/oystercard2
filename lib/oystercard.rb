class Oystercard

  DEF_BAL = 0
  MIN_BAL = 1
  MAX_BAL = 90

  attr_reader :journey_log

  def initialize(journey_log:)
    @balance = DEF_BAL
    @journey_log = journey_log
  end

  def top_up(amount)
    fail("You cannot exceed £#{MAX_BAL}") if invalid_top_up?(amount)
    @balance += amount
  end

  def touch_in(entry_station = nil)
    deduct(last_journey.fare) if in_journey?
    fail("You have insufficient funds") if insufficient_funds?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station = nil)
    @journey = @journey_log.finish(exit_station)
    deduct(@journey.fare)
  end

  def show_balance
    @balance.dup
  end

  private

  def last_journey
    @journey_log.journeys[-1]
  end

  def in_journey?
    return false if last_journey.nil?
    return false if last_journey.complete?
    return true
  end

  def deduct(amount)
    @balance -= amount
  end

  def invalid_top_up?(amount)
    (@balance + amount) > MAX_BAL
  end

  def insufficient_funds?
    @balance < MIN_BAL
  end

end
