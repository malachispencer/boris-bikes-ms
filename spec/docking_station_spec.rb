require 'docking_station'
require 'bike'

describe DockingStation do

  context 'when release_bike is called' do 
    it 'responds to the method release_bike' do
      expect(subject).to respond_to(:release_bike)
    end
  end

  context 'when release_bike is called' do
    it 'returns a bike instance' do
      subject.dock(double(:bike))
      expect(subject.release_bike).to be_instance_of(Bike)
    end
  end

  context 'when dock is called' do
    it 'pushes a bike into the bikes array' do
      expect { subject.dock(double(:bike) }.to change { subject.bikes.length }.by(1)
    end
  end

  context 'when public bikes attr is accessed' do
    it 'shows all the available bikes' do
      expect(subject.bikes).to be_instance_of(Array)
    end
  end

  context 'when release_bikes is called' do
    it 'raises an error when there are no bikes' do
      expect { subject.release_bike }.to raise_error(RuntimeError)
    end
  end

  context 'when dock is called' do 
    it 'raises an error if capacity is full' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(double(:bike)) }
      expect { subject.dock(double(:bike)) }.to raise_error(RuntimeError)
    end
  end

  context 'when class is instantiated' do
    let(:station) { DockingStation.new(77) }
    it 'allows user to set a capacity instance variable' do
      expect(station.capacity).to eq(77)
    end
  end

  context 'when class is instantiated' do
    it "default capacity of 20 is set if user doesn't set a capacity" do
      expect(subject.capacity).to eq(20)
    end
  end

  context 'when release bikes is called' do
    it "doesn't release a bike that is broken" do
      3.times { subject.dock(double(:bike)(false)) }
      2.times { subject.dock(double(:bike)) }
      expect(subject.release_bike.working?).to eq(true)
    end
  end

  context 'when release bikes is called' do
    it 'raises error if all bikes are broken' do
      5.times { subject.dock(double(:bike)(false)) }
      expect { subject.release_bike }.to raise_error "All bikes currently out of order"
    end
  end
end
