require 'geocoder'

Geocoder.configure(lookup: :geocoder_ca, timeout: 5)

# full_address = '1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S.'
#
def geocode(full_address)

  result = Geocoder.search(full_address)
end

def reverse_geocode(lat, lng)

  result = Geocoder.search("#{lat}, #{lng}")
end
