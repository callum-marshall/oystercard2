class JourneyLog

  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    @current_journey = @journey_class.new(station)
    @journeys << @current_journey
    @current_journey
  end

  def finish(station)
    @journey = current_journey
    @current_journey = nil
    @journey.finish(station)
  end

  def journeys
    @journeys.dup
  end

  def print_journeys
    string = ""
    @journeys.each do |journey|
      string << journey_formatter(journey)
    end
    return string
  end

  private

  def current_journey
    @current_journey ||= start
  end

  def journey_formatter(journey)
    entry = "#{journey.entry_station.name} (Zone #{journey.entry_station.zone})"
    exit = "#{journey.exit_station.name} (Zone #{journey.exit_station.zone})\n"
    "From: #{entry} To: #{exit}"
  end

end
