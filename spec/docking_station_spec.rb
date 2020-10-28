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
      subject.dock(Bike.new)
      expect(subject.release_bike).to be_instance_of(Bike)
    end
  end

  context 'when dock is called' do
    it 'pushes a bike into the bikes array' do
      expect { subject.dock(Bike.new) }.to change { subject.bikes.length }.by(1)
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
      max_capacity = DockingStation::DEFAULT_CAPACITY
      max_capacity.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new) }.to raise_error(RuntimeError)
    end
  end
end
