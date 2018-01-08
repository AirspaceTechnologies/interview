require 'spec_helper'
require "geocoder/results/#{Geocoder.config[:lookup]}"

RSpec.describe Main do
	include Rack::Test::Methods
	let(:app) { described_class }
	subject(:response) { last_response }

	context "GET /" do
		
		before do 
			get '/'
		end

		it 'returns OK' do 
			expect(response).to be_ok
		end

		it 'returns HTML' do
			expect(response.headers["Content-Type"]).to eq "text/html;charset=utf-8"
		end

	end

	context "POST /reverse_geocode" do
		let(:geocoder_result_class) { "Geocoder::Result::#{Geocoder.config[:lookup].to_s.classify}".constantize }

		let(:params) { {lat: 40.181306, lng: -80.265949} }
		let(:geocoder_result) do 
			[ geocoder_result_class.new({
          'city' => 'WASHINGTON',
          'stnumber' => '1',
          'prov' => 'PA',
          'zip' => '20500',
          'staddress' => 'Pennsylvania AVE'
        }) ]
		end

		before do 
			allow(Geocoder).to receive(:search).and_return geocoder_result
			post '/reverse_geocode', params
		end

		it 'returns OK' do 
			expect(response).to be_ok
		end

		it 'returns JSON' do
			expect(response.headers["Content-Type"]).to eq "application/json"
		end

		it 'returns the saved address' do
			expect(response.body).to eq Address.first.json_attributes.to_json
		end

		it 'creates a reverse geocoded address' do
			expect(Address.first).to be_reverse_geocoded
		end


	end


	context "DELETE /clear_all" do
		
		let(:addresses) { FactoryGirl.create_list(:address, 5) }

		before do 
			addresses
			delete '/clear_all'
		end

		it 'returns OK' do 
			expect(response).to be_ok
		end

		it 'returns JSON' do
			expect(response.headers["Content-Type"]).to eq "application/json"
		end

		it 'returns the deleted addresses' do
			expect(response.body).to eq addresses.to_json
		end

		it 'destroys all addresses' do
			expect(Address.count).to eq 0
		end

	end


end