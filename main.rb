require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
    # provide the coordinates 
    coordinates = [
            {lat: 61.582195, lng: -149.443512},
            {lat: 44.775211, lng: -68.774184},
            {lat: 25.891297, lng: -97.393349},
            {lat: 45.787839, lng: -108.502110},
            {lat: 35.109937, lng: -89.959983}
          ]

    # Get address for each
    addresses = []
    white_house_coordinate = Geocoder.coordinates("1600 Pennsylvania Avenue NW Washington, D.C. 20500")
    coordinates.each do |a|
      results = Geocoder.search([a[:lat], a[:lng]])
      determined_distance = Geocoder::Calculations.distance_between([a[:lat], a[:lng]], white_house_coordinate) 
      addresses << {address: results.first.address, determined_distance: determined_distance}
    end

    addresses = addresses.sort_by { |a| a[:determined_distance] }

    erb :index, locals: { addresses: addresses }
  end
end
