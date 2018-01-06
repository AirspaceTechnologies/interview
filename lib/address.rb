require_relative 'geocoding'
require 'sinatra/activerecord'
require 'geocoder/models/active_record'


class Address < ActiveRecord::Base
  # attr_accessor :lat, :lng, :full_address
  extend Geocoder::Model::ActiveRecord
  geocoded_by :full_address, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng, address: :full_address

  WHITE_HOUSE = Address.new(lat: 38.8976633, lng: -77.0365739)

  def reverse_geocoded?
  	!full_address.nil?
  end

  def coordinates
  	[lat, lng]
  end

  def coordinates=(point)
  	self.lat = point[0]
  	self.lng = point[1]
  	coordinates
  end

  def distance_to(point, units = nil)
  	point = point.coordinates if point.respond_to?(:coordinates)
  	super
  end

  def miles_to(point)
  	distance_to(point, :mi)
  end

  def miles_to_dc
    miles_to(WHITE_HOUSE)
  end

  def json_attributes
    attributes.dup.merge({miles_to_dc: miles_to_dc.round(2)})
  end

  # def to_json
  #   attributes.dup.merge({miles_to_dc: miles_to_dc}).to_json
  # end


end
