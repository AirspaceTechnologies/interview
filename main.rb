require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/addresses' do
    erb :addresses, locals: { addresses: addresses }
  end

  helpers do
    def addresses
      Address.load('data/addresses.yml')
    end
  end
end
