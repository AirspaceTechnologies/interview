require 'sinatra/base'
require 'concurrent'

Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  # Configuration helpers
  #
  # Warms the application cache for a certain key
  # Expects a key and &block to execute/yield for the value
  def self.warm_cache(key)
    contents = yield
    if contents.respond_to?(:each)
      contents = contents.map!(&:freeze)
    else
      contents.freeze!
    end
    settings.cache[key] = contents
  end

  configure do
    set :cache, Concurrent::Hash.new(0)
    # Warm up the cache with addresses
    # TODO: No tests!
    warm_cache(:addresses) { Address.load('data/addresses.yml') } unless ENV['RACK_ENV'] == 'test'
  end

  get '/' do
    erb :index
  end

  get '/addresses' do
    erb :addresses, locals: { addresses: addresses }
  end

  helpers do
    def addresses
      settings.cache[:addresses]
    end
  end
end
