require_relative './docking_station'
require_relative './garage'

class Van
  def transport_broken(station, garage)
    raise 'No broken bikes' if station.broken_bikes.empty?

    until station.broken_bikes.empty? do
      garage.garage_bikes << station.broken_bikes.shift
    end
  end

  def transport_fixed(garage, station)
    raise 'Bikes must all be fixed' if garage.garage_bikes.any? {|bike| bike.working == false}

    until garage.garage_bikes.empty? do
      station.dock(garage.garage_bikes.shift)
    end
  end
end