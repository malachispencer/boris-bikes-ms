require 'garage'
require 'van'

describe Garage do
  context 'bikes attr accessor' do
    it 'receives an array of bikes from Van' do
      station = DockingStation.new(0)
      van = Van.new
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { station.dock(working_bike) }
      2.times { station.dock(broken_bike) }
      station.ready_for_repair
      van.transport_broken(station, subject)
      subject.garage_bikes.each do |bike|
        expect(bike.working).to eq(false)
      end
    end
  end
end