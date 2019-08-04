class Journey

  EXAMPLE_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    return self
  end

  def complete?
    @entry_station && @exit_station
  end

  def fare
    self.complete? ? EXAMPLE_FARE : PENALTY_FARE
  end

end
