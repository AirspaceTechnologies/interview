require_relative 'geocoding'


class Address
  geocoded_by :address       
  after_validation :geocode

  attr_accessor :lat, :lng, :full_address

  def initialize (lat, lng, full_address=nil)
    @lat = lat
    @lng = lng
    @full_address = full_address || find_address(:lat, :lng)
  end

  # def self.all
  #   address = []
  #   @@list.each do |coordinates|
  #     Address.new(coordinates.lat, coordinates.lng)
  #   end
  #   address
  # end

  def find_address(lattitude, longitude)
    reverse_geocoded_address = Geocoder.reverse_geocoded_by :lattitude, :longitude
    puts reverse_geocoded_address
  end

end
