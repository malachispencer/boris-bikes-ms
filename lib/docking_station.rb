require_relative './bike.rb'

class DockingStation
  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise 'No bikes to release' if @bikes.empty?
    @bikes.shift
  end

  def dock(bike)
    raise 'Docking station full' if full?
    @bikes.push(bike)
  end

  private

  def full?
    @bikes.length >= DEFAULT_CAPACITY
  end
end