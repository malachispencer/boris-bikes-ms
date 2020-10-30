require 'van'
require 'docking_station'
require 'garage'

describe Van do
  context '#transport_broken' do
    it 'removes broken bikes from DockingStation' do
      station = DockingStation.new(0)
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { station.dock(working_bike) }
      2.times { station.dock(broken_bike) }
      station.ready_for_repair
      expect { subject.transport_broken(station, Garage.new) }.to change { station.broken_bikes.length }.by(-2)
    end

    it 'places broken bikes in Garage' do
      station = DockingStation.new(0)
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { station.dock(working_bike) }
      2.times { station.dock(broken_bike) }
      station.ready_for_repair
      garage = Garage.new
      expect { subject.transport_broken(station, garage) }.to change { garage.garage_bikes.length }.by(2)
    end

    it "doesn't transport bikes if none are broken" do
      station = DockingStation.new
      station.ready_for_repair
      expect { subject.transport_broken(station, Garage.new) }.to raise_error('No broken bikes')
    end
  end
end