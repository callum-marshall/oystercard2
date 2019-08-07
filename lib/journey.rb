class Journey

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
    complete? ? fare_calc : PENALTY_FARE
  end

  private

  def fare_calc
    if @entry_station.zone > @exit_station.zone
      @entry_station.zone - @exit_station.zone + 1
    else
      @exit_station.zone - @entry_station.zone + 1
    end
  end


end
