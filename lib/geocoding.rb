require 'geocoder'

Geocoder.configure(lookup: :geocoder_ca, timeout: 5)

class AccessGeocoder
    def self.geocode(full_address)
      Geocoder.search(full_address)
    end

    def self.reverse_geocode(lat, lng)
      Geocoder.search("#{lat}, #{lng}")
    end
end
