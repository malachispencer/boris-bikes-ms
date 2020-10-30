require_relative './docking_station'

class Van
  def transport_broken(station, garage)
    raise 'No broken bikes' if station.broken_bikes.empty?

    until station.broken_bikes.empty? do
      garage.garage_bikes << station.broken_bikes.shift
    end
  end
end