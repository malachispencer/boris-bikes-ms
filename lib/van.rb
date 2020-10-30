require_relative './docking_station'

class Van
  def transport_broken(station, garage)
    until station.broken_bikes.empty? do
      garage << station.broken_bikes.shift
    end
    garage
  end
end