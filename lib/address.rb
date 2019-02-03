require_relative 'geocoding'

class Address
  @@list = []

  attr_accessor :lat, :lng, :full_address

  def initialize (lat lng full_address=nil)
    @lat = lat
    @lng = lng
    @full_address = full_address
  end



end
