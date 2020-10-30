require 'van'
require 'docking_station'

describe Van do
  context '#transport_broken' do
    it 'moves broken bikes from Docking Station to Garage' do
      station = DockingStation.new(0)
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { station.dock(working_bike) }
      2.times { station.dock(broken_bike) }
      station.ready_for_repair
      garage = []
      expect { subject.transport_broken(station, garage) }.to change { garage.length }.by(2)
    end
  end
end