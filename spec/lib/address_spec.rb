
RSpec.describe Address do
  let(:white_house) { FactoryGirl.build(:address, :as_white_house) }
  let(:full_address) { white_house.full_address }
  let(:lat) { white_house.lat }
  let(:lng) { white_house.lng }

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

    it 'calculates distance with the Geocoder API' do
      expect(Geocoder::Calculations).to receive(:distance_between).with detroit.coordinates, kansas_city.coordinates
      detroit.miles_to(kansas_city)
    end

    it 'returns the distance between two addresses' do
      expect(detroit.miles_to(kansas_city)).to be > 0
    end
  end

  describe 'load' do
    subject { Address.load('dummy/data.yml') }
    before do
      expect(File).to receive(:exist?).at_least(:once).and_return(true) # TODO: expecting with the path throws a uninitialized constant RSpec::Support::Differ. No idea.
    end
    context 'with address' do
      before do
        expect(YAML).to receive(:load_file).with('dummy/data.yml').and_return([{ 'full_address' => full_address }])
      end
      it 'should create legit record' do
        created = subject.first
        expect(created.full_address).to eq full_address
        expect(created.lat).to eq lat
        expect(created.lng).to eq lng
        # expect(subject).to eq 1
      end
    end
    context 'with lat/lng' do
      before do
        expect(YAML).to receive(:load_file).with('dummy/data.yml').and_return([{ 'lat' => lat, 'lng' => lng }])
      end
      it 'should create legit record' do
        created = subject.first
        expect(created.full_address).to eq full_address
        expect(created.lat).to eq lat
        expect(created.lng).to eq lng
      end
    end
  end
end
