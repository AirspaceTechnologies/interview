require 'geocoder'

if ENV['RACK_ENV'] == 'test'
  Geocoder.configure(lookup: :test)
else
  Geocoder.configure(lookup: :geocoder_ca, timeout: 5)
end
