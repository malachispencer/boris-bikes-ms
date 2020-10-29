require 'docking_station'
require 'bike'

describe DockingStation do
  context '#initialize' do
    let(:station) { DockingStation.new(77) }
    it 'allows user to set a capacity instance variable' do
      expect(station.capacity).to eq(77)
    end

    it "default capacity of 20 is set if user doesn't set a capacity" do
      expect(subject.capacity).to eq(20)
    end
  end

  context '#release_bike' do 
    it 'can be called on a DockingStation object' do
      expect(subject).to respond_to(:release_bike)
    end

    it 'raises an error when there are no bikes' do
      expect { subject.release_bike }.to raise_error(RuntimeError)
    end

    it 'raises an error if all bikes are broken' do
      5.times { subject.dock(Bike.new(false)) }
      expect { subject.release_bike }.to raise_error('All bikes currently out of order')
    end

    it 'returns a bike instance' do
      subject.dock(Bike.new)
      expect(subject.release_bike).to be_instance_of(Bike)
    end

    it "doesn't release a bike that is broken" do
      3.times { subject.dock(Bike.new(false)) }
      2.times { subject.dock(Bike.new) }
      expect(subject.release_bike.working?).to eq(true)
    end
  end

  context '#dock' do
    it 'raises an error if capacity is full' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new) }.to raise_error('Docking station full')
    end

    it 'pushes a bike into the bikes array' do
      expect { subject.dock(Bike.new) }.to change { subject.bikes.length }.by(1)
    end
  end

  context 'bikes attr reader' do
    it 'shows all the available bikes' do
      expect(subject.bikes).to be_instance_of(Array)
    end
  end
end
