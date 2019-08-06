class JourneyLog

  attr_reader :journeys

  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    @current_journey = @journey_class.new(entry_station: station)
    @journeys << @current_journey
    @current_journey
  end

  def finish(station)
    @current_journey = current_journey
    @current_journey.finish(exit_station: station)
  end

  private

  def current_journey
    @current_journey ||= start
  end

end
