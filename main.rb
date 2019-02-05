require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
    @dc_address = "1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S."
    @coordinate_list = [
        {lat: 61.582195, lng: -149.443512, full_address: "1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S."},
        {lat: 44.775211, lng: -68.774184},
        {lat: 25.891297, lng: -97.393349},
        {lat: 45.787839, lng: -108.502110},
        {lat: 35.109937, lng: -89.959983}
    ]

    @address_list = []

    # @coordinate_list.each do | coordinates |
    #     address = Address.new(coordinates).find_address
    #     puts address
    #     @address_list.push(address)
    # end

    erb :index2 #, locals: { address: address }
  end


end
