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

    let(:docked_station) { DockingStation.new(33, 33) }
    it 'contains an array with user defined docked amount of bikes' do 
      expect(docked_station.bikes.length).to eq(33)
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
      3.times { all_broken_station.dock(Bike.new(false)) }
      expect { all_broken_station.release_bike }.to raise_error('All bikes currently out of order')
    end

    it 'returns a bike instance' do
      expect(subject.release_bike).to be_instance_of(Bike)
    end

    let(:some_broken_station) { DockingStation.new(0) }
    it "doesn't release a bike that is broken" do
      3.times { some_broken_station.dock(Bike.new(false)) }
      2.times { some_broken_station.dock(Bike.new) }
      expect(some_broken_station.release_bike.working).to eq(true)
    end
  end

  context '#dock' do
    it 'raises an error if capacity is full' do
      expect { subject.dock(Bike.new) }.to raise_error('Docking station full')
    end

    let(:station) { DockingStation.new(19) }
    it 'pushes a bike into the bikes array' do
      expect { station.dock(Bike.new) }.to change { station.bikes.length }.by(1)
    end
  end

  context 'bikes attr reader' do
    it 'shows all the available bikes' do
      expect(subject.bikes).to be_instance_of(Array)
    end
  end
end
