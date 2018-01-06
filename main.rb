require_relative 'config/environment'
require 'sinatra/base'

Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
  	coordinates = [
  		[61.582195, -149.443512], 
  		[44.775211, -68.774184], 
  		[25.891297, -97.393349], 
  		[45.787839, -108.502110],
  		[35.109937, -89.959983]
  	]
  	addresses = Address.all
    erb :index, locals: { addresses: addresses, coordinates: coordinates, whiteHouse: Address::WHITE_HOUSE }
  end

  delete '/clear_all' do
  	Address.destroy_all.to_json
  end

  post '/reverse_geocode' do
  	address = Address.new(lat: params[:lat], lng: params[:lng])
  	address.reverse_geocode
  	address.save ## Comment out to disable caching. If caching is disabled consider allowing all the ajax calls at once in js.
  	address.json_attributes.to_json
  end


end
