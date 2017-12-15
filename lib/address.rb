require_relative 'geocoding'
require 'yaml'

# Represents an Address or location
class Address
  attr_accessor :lat, :lng, :full_address

  def initialize(attrs = {})
    @cached_distances = {}
    attrs.each_key do |key|
      m = "#{key}="
      public_send(m, attrs.fetch(key)) if respond_to?(m)
    end
    update_address_and_coordinates_with_service_if_needed
  end

  def self.miles_between(*coords)
    Geocoder::Calculations.distance_between(*coords)
  end

  def self.load(yml_file_path)
    return false unless File.exist?(yml_file_path)
    data = YAML.load_file(yml_file_path)
    data.collect do |attributes|
      # attributes.slice!(:full_address, :lat, :lng)
      record = new(full_address: attributes.fetch('full_address', nil), lat: attributes.fetch('lat', nil), lng: attributes.fetch('lng', nil))
      record
    end
  end

  def coordinates
    [lat, lng]
  end

  def miles_to(other_address)
    # Might want to type check/ validate other_address here
    coords = other_address&.coordinates

    # Lets memoize these results, at least at the instance level.
    @cached_distances.fetch(coords) do
      @cached_distances[coords] = Address.miles_between(coordinates, other_address&.coordinates)
    end
  end

  # The object has coordinates
  # @return [true, false]
  def geocoded?
    coordinates.none?(&:!) # Short form of { |coordinate| !coordinate }
  end

  # The object has an address
  # @return [true, false]
  def reverse_geocoded?
    # I usually avoid !!, but without a helper like Rail's `present`,
    # I prefer it over checking nil/empty
    !!full_address
  end

  def update_address_and_coordinates_with_service_if_needed
    if full_address && !geocoded?
      update_coordinates_with_service
    elsif !full_address && geocoded?
      update_address_with_service
    end
  end

  def update_coordinates_with_service
    self.lat, self.lng = Geocoder.search(full_address)&.first&.coordinates
  end

  def update_address_with_service
    self.full_address = Geocoder.search(coordinates.join(','))&.first&.address
  end
end
