require 'docking_station'
require 'bike'

describe DockingStation do
  context '#initialize' do
    let(:station) { DockingStation.new(77, 77) }
    it 'allows user to set a capacity instance variable' do
      expect(station.capacity).to eq(77)
    end

    it "default capacity of 20 is set if user doesn't set a capacity" do
      expect(subject.capacity).to eq(20)
    end

    it 'contains an array with user defined docked amount of bikes' do
      expect(station.bikes.length).to eq(77)
    end

    let(:false_station) { DockingStation.new(21) }
    it 'raises error if user sets higher docked than capacity' do
      expect { false_station }.to raise_error('Docked must be less than or equal to capacity')
    end
  end

  context '#release_bike' do 
    it 'can be called on a DockingStation object' do
      expect(subject).to respond_to(:release_bike)
    end

    let(:empty_station) { DockingStation.new(0) }
    it 'raises an error when there are no bikes' do
      expect { empty_station.release_bike }.to raise_error(RuntimeError)
    end

    let(:all_broken_station) { DockingStation.new(0) }
    it 'raises an error if all bikes are broken' do
      broken_bike = double('bike', :working => false)
      3.times { all_broken_station.dock(broken_bike) }
      expect { all_broken_station.release_bike }.to raise_error('All bikes currently out of order')
    end

    it 'returns a bike instance' do
      expect(subject.release_bike).to be_instance_of(Bike)
    end

    let(:some_broken_station) { DockingStation.new(0) }
    it "doesn't release a bike that is broken" do
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { some_broken_station.dock(broken_bike) }
      2.times { some_broken_station.dock(working_bike) }
      expect(some_broken_station.release_bike.working).to eq(true)
    end
  end

  context '#dock' do
    let(:bike) { double :bike }
    it 'raises an error if capacity is full' do
      expect { subject.dock(bike) }.to raise_error('Docking station full')
    end

    let(:station) { DockingStation.new(19) }
    it 'pushes a bike into the bikes array' do
      expect { station.dock(bike) }.to change { station.bikes.length }.by(1)
    end
  end

  context 'bikes attr reader' do
    it 'shows all the available bikes' do
      expect(subject.bikes).to be_instance_of(Array)
    end
  end

  context '#ready_for_repair' do
    it 'moves all broken bikes to seperate array' do
      station = DockingStation.new(0)
      broken_bike = double('broken_bike', :working => false)
      working_bike = double('working_bike', :working => true)
      3.times { station.dock(working_bike) }
      2.times { station.dock(broken_bike) }
      station.ready_for_repair
      station.broken_bikes.each {|bike| expect(bike.working).to eq(false)}
    end
  end
end
