require "geocoder/results/#{Geocoder.config[:lookup]}"

RSpec.describe Address do
  let(:full_address) { '1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S.' }
  let(:lat) { 40.181306 }
  let(:lng) { -80.265949 }

  let(:geocoder_result_class) { "Geocoder::Result::#{Geocoder.config[:lookup].to_s.classify}".constantize }

  subject(:address) { described_class.new }

  describe 'geocoding' do
    let(:payload) {{  'longt' => lng, 'latt' => lat }}
    let(:result) { [geocoder_result_class.new(payload)] }
    # let(:result) { [ double(data: payload) ] }

    before do
      address.full_address = full_address
    end

    it 'geocodes with Geocoder API' do
      expect(Geocoder).to receive(:search).with(full_address, {:lookup=>nil, :language=>nil}).and_return result
      address.geocode
    end

    it 'is geocoded' do
      allow(Geocoder).to receive(:search).and_return result
      address.geocode
      expect(address).to be_geocoded
    end
  end

  describe 'reverse geocoding' do
    let :payload do
      {   
        'usa'=> {
          'uscity' => 'WASHINGTON',
          'usstnumber' => '1',
          'state' => 'PA',
          'zip' => '20500',
          'usstaddress' => 'Pennsylvania AVE'
        }
      }
    end
   
    let(:result) { [ geocoder_result_class.new(payload) ] }
     # let(:result) { [ double(data: payload) ] }

     before do
       address.lat = lat
       address.lng = lng
     end

    it 'reverse geocodes with Geocoder API' do
      expect(Geocoder).to receive(:search).with([lat, lng], {:lookup=>nil, :language=>nil}).and_return result
      address.reverse_geocode
    end

    it 'is reverse geocoded' do
      allow(Geocoder).to receive(:search).and_return result
      address.reverse_geocode
      expect(address).to be_reverse_geocoded
    end
  end

  describe 'distance finding' do
    let(:detroit) { FactoryGirl.build :address, :as_detroit }
    let(:kansas_city) { FactoryGirl.build :address, :as_kansas_city }

    it 'calculates distance with the Geocoder API' do
      expect(Geocoder::Calculations).to receive(:distance_between).with detroit.coordinates, kansas_city.coordinates, {units: nil}
      detroit.distance_to kansas_city
    end

    it 'returns the distance between two addresses' do
      expect(detroit.miles_to(kansas_city)).to be > 0
    end
  end
end
