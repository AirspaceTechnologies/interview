require_relative 'geocoding'


class Address
  attr_accessor :lat, :lng, :full_address

  # def initialize ()
  #   if !full_address then
  #     Geocoder.search("#{@lat}, #{@lng}")
  #   else
  #     Geocoder.search(@full_address)
  #   end
  # end

  # if @full_address == nil then
  #     Geocoder.search("#{@lat}, #{@lng}")
  #   else
  #     Geocoder.search(@full_address)
  #   end
  #
  def self.geocode
    @self = Geocode.search(self.full_address)
  end
  #
  # def reverse_geocoded
  #   full_address = Geocode.search(lat, lng)
  # end

  # def self.all
  #   address = []
  #   @@list.each do |coordinates|
  #     Address.new(coordinates.lat, coordinates.lng)
  #   end
  #   address
  # end

end
