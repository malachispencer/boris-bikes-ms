require_relative './bike.rb'

class DockingStation
  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(docked = DEFAULT_CAPACITY, capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = Array.new(docked) { Bike.new }
  end

  def release_bike
    raise 'No bikes to release' if @bikes.empty?
    raise 'All bikes currently out of order' if all_broken?
    @bikes.delete_at( @bikes.index { |bike| bike.working == true } )
  end

  def dock(bike)
    raise 'Docking station full' if full?
    @bikes.push(bike)
  end

  private

  def full?
    @bikes.length >= @capacity
  end

  def all_broken?
    @bikes.all? {|bike| bike.working == false}
  end
end