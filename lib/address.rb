require_relative 'geocoding'


class Address
  attr_accessor :lat, :lng, :full_address

  def initialize()

  end
  # @full_address = args[:full_address] || find_address(args[:lat], args[:lng])

  # def lat
  #   @lat ||= Geocoder.search("#{lat}, #{lng}").first.standard
  # end
  #
  # def full_address
  #   @full_address ||= Geocoder.search("#{lat}, #{lng}").first.standard
  # end
  #
  def find_address
  end

  def find_lat_lng
    geocode(self.full_address)
  end

  def geocoded?
    defined?(lat) && defined?(lng)
  end

  def reverse_geocoded?
    defined?(full_address)
  end

end
