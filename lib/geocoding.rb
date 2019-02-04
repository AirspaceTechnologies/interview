require 'geocoder'

Geocoder.configure(lookup: :geocoder_ca, timeout: 5)

def geocode full_address
  coordinates = Geocoder.coordinates(full_address)
  return coordinates
end
