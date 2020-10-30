require 'bike'

describe Bike do
  context '#initialize' do
    let(:bike) { Bike.new(false) }
    it 'allows user to set working or broken' do
      expect(bike.working).to eq(false)
    end
  end

  context 'working attr accessor' do
    it 'expects bike to be working' do
      expect(subject.working).to eq(true)
    end
  end
end