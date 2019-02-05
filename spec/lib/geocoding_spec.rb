RSpec.describe Geocoder do
  describe 'configuration' do
    it 'is configured with a default stub in test mode' do
      result = Geocoder.search('All roads lead to Carlsbad')
      expect(result.first.address).to eq('Carlsbad, CA, USA')
    end

  end

  describe 'geolocation' do
    it 'geocodes: looks up coordinates of an address' do
      address = 'Pasadena'
      coordinates = [3, 0.14]
      Geocoder::Lookup::Test.add_stub(address, [
          {
              'coordinates'  => coordinates,
              'address'      => address,
          }
      ])
      result = Geocoder.search(address)
      expect(result.first.coordinates).to eq(coordinates)
    end

    it 'reverse geocodes: looks up an address based on coordinates' do
      address = 'Pasadena'
      coordinates = [3, 0.14]
      Geocoder::Lookup::Test.add_stub(coordinates.join(','), [
          {
              'coordinates'  => coordinates,
              'address'      => address,
          }
      ])
      result = Geocoder.search(coordinates.join(','))
      expect(result.first.coordinates).to eq(coordinates)
    end
  end
end
