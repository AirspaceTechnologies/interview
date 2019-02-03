require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do

    @list = [
        {lat: 61.582195, lng: -149.443512},
        {lat: 44.775211, lng: -68.774184},
        {lat: 25.891297, lng: -97.393349},
        {lat: 45.787839, lng: -108.502110},
        {lat: 35.109937, lng: -89.959983}
    ]

    @address_list = []

    @list.each do | coordinate |
        @address_list.push(Address.new(coordinate[:lat], coordinate[:lng]))
    end

    erb :index #, locals: { address: address }
  end

  # post '/address' do
  #   require 'pry'; binding.pry
  #   params.to_s
  # end

end
