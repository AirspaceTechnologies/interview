require 'geocoder'

Geocoder.configure(lookup: :geocoder_ca, timeout: 5)

# def geocode full_address
#     = Geocoder.coordinates(full_address)
#   return coordinates
# end
def geocode (full_address)
  coordinates = Geocode.search(full_address)
  puts coordinates
end

def reverse_geocoded
  full_address = Geocode.search(lat, lng)
end
