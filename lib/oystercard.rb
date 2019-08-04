require 'journey'

class Oystercard

  DEF_BAL = 0
  MIN_BAL = 1
  MAX_BAL = 90

  attr_reader :balance, :journey_history

  def initialize
    @balance = DEF_BAL
    @journey_history = []
  end

  def top_up(amount)
    raise("You cannot exceed £#{MAX_BAL}") if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in(entry_station = nil)
    raise("You have insufficient funds") if @balance < MIN_BAL
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station = nil)
    @journey.finish(exit_station)
    deduct(@journey.fare)
    @journey_history << @journey
  end

  def in_journey?
    if @journey.is_a?(Journey)
      !@journey.complete?
    else
      false
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
