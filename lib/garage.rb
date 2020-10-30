class Garage
  attr_accessor :garage_bikes

  def initialize
    @garage_bikes = []
  end

  def repair_bikes
    @garage_bikes.map { |bike| bike.working = true }
  end

end