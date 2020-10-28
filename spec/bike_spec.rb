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
end