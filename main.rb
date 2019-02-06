require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
    @washington_dc = Address.new(:full_address => "1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S.")
    @washington_dc.find_lat_lng
    @coordinate_list = [
        {lat: 61.582195, lng: -149.443512},
        {lat: 44.775211, lng: -68.774184},
        {lat: 25.891297, lng: -97.393349},
        {lat: 45.787839, lng: -108.502110},
        {lat: 35.109937, lng: -89.959983}
    ]

    @address_list = []

    @coordinate_list.each do | coordinates |
        @address = Address.new(coordinates)
        @address.find_address
        @address.last_distance = @address.miles_to(@washington_dc)
        @address_list.push(@address)
    end

    @address_list.sort! { |a, b|  a.last_distance <=> b.last_distance }

    erb :index2 #, locals: { address: address }
  end


end
