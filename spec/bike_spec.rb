require 'bike'

describe Bike do
  context 'when working? is called' do
    it 'responds to the method working?' do
      expect(subject).to respond_to(:working?)
    end
  end

  context 'when working? is called' do
    it 'expects bike to be working' do
      expect(subject.working?).to eq(true)
    end
  end

  context 'when class is instantiated' do
    let(:bike) { Bike.new(false) }
    it 'allows user to set working attribute' do
      expect(bike.working).to eq(false)
    end
  end
end