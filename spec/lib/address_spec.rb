
RSpec.describe Address do
  let(:full_address) { '1600 Pennsylvania Avenue NW Washington, D.C. 20500 USA' }
  let(:lat) { 38.8976633 }
  let(:lng) { -77.0365739 }

  before do
    Geocoder::Lookup::Test.add_stub(
      full_address, [
        { 'coordinates' => [lat, lng] }
      ]
    )
    Geocoder::Lookup::Test.add_stub(
      [lat, lng].join(','), [
        {
          'address' => full_address,
          'city' => 'Washington',
          'state'        => 'District of Columbia',
          'state_code'   => 'DC',
          'country'      => 'United States',
          'country_code' => 'US',
          'postal_code'  => '20500'
        }
      ]
    )
  end

  describe 'geocoding' do
    subject(:address) { described_class.new(full_address: full_address) }

    it { is_expected.to be_geocoded }
    it 'geocodes with Geocoder API' do
      expect(Geocoder).to receive(:search).with(full_address).and_call_original
      address
    end
  end

  describe 'reverse geocoding' do
    subject(:address) { described_class.new(lat: lat, lng: lng) }

    it { is_expected.to be_reverse_geocoded }
    it 'reverse geocodes with Geocoder API' do
      expect(Geocoder).to receive(:search).with("#{lat},#{lng}").and_call_original
      address
    end
  end

  describe 'distance finding' do
    let(:detroit) { FactoryGirl.build :address, :as_detroit }
    let(:kansas_city) { FactoryGirl.build :address, :as_kansas_city }

    xit 'calculates distance with the Geocoder API' do
      expect(Geocoder::Calculations).to receive(:distance_between).with detroit.coordinates, kansas_city.coordinates
    end

    xit 'returns the distance between two addresses' do
      expect(detroit.miles_to(kansas_city)).to be > 0
    end
  end
end
