require 'rack/test'

RSpec.describe Main do
  describe 'Main application' do
    include Rack::Test::Methods

    def app
      Main
    end

    it 'Serves / ok' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'Serves 404 on other routes' do
      get '/foo'
      expect(last_response.status).to eq(404)
    end
  end
end
