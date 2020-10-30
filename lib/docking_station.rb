require_relative './bike.rb'

class DockingStation
  attr_reader :bikes, :capacity, :broken_bikes

  DEFAULT_CAPACITY = 20

  def initialize(docked = DEFAULT_CAPACITY, capacity = DEFAULT_CAPACITY)
    raise 'Docked must be less than or equal to capacity' if docked > capacity
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

  def ready_for_repair
    @broken_bikes = []

    while @bikes.any? {|bike| !bike.working} do
      broken = @bikes.index {|bike| !bike.working}
      @broken_bikes << @bikes.slice!(broken)
    end

    @broken_bikes
  end

  private

  def full?
    @bikes.length >= @capacity
  end

  def all_broken?
    @bikes.all? {|bike| bike.working == false}
  end
end