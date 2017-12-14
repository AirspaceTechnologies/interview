require 'spec_helper'

RSpec.describe 'Addresses' do
  include Rack::Test::Methods

  def app
    Main
  end

  describe :index do
    let(:addresses) { FactoryGirl.build_list(:address, 3) }
    before do
      expect(Main.settings.cache).to receive(:[]).with(:addresses).and_return(addresses)
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
  end
end
