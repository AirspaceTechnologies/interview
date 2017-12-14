require 'spec_helper'

RSpec.describe 'Addresses' do
  include Rack::Test::Methods

  def app
    Main
  end

  describe :index do
    let(:addresses) { FactoryGirl.build_list(:address, 3) }
    let(:white_house) { FactoryGirl.build(:address, :as_white_house) }
    before do
      expect(Main.settings.cache).to receive(:[]).with(:addresses).and_return(addresses).once
      expect(Main.settings.cache).to receive(:[]).with(:white_house).and_return(white_house).exactly(3).times
      addresses.each {|a| expect(a).to receive(:miles_to).with(white_house).and_return(1)}
      get '/addresses'
    end
    subject(:response) { last_response }

    it { is_expected.to be_ok }
    it 'contains the 3 created addresses' do
      # This is very high level-- if you want more detail, we should go to capybara or the like
      addresses.each do |address|
        expect(last_response.body).to match(address.full_address)
      end
    end

    # I really don't want to get into regex checking for distance
    #it 'contains the distance from each address to the white house' do
    #  addresses.each do |address|
    #    expect(last_response.body).to match()
    #  end
    #end
  end
end
