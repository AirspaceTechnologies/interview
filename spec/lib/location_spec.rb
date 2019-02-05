RSpec.describe Location do
  describe 'instantiation' do
    it 'has attribute accessors for "coordinates" and "address"' do
      location = Location.new
      location.coordinates = [1, 2]
      location.address = 'Minnesota'
      expect(location.coordinates).to eq([1, 2])
      expect(location.address).to eq('Minnesota')
    end
  end
end
