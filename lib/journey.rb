class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @fare = PENALTY_FARE
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    return self
  end

end
