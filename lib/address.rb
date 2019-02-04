require_relative 'geocoding'


class Address
  attr_accessor :lat, :lng, :full_address

  def initialize (full_address)
    @full_address = full_address
  end


  def get_lat_lng(full_address)
    coordinates = geocode(full_address)
    puts coordinates
  end
  # def self.all
  #   address = []
  #   @@list.each do |coordinates|
  #     Address.new(coordinates.lat, coordinates.lng)
  #   end
  #   address
  # end

end
