require 'geocoder'

if ENV['APP_ENV'] == 'test'
  Geocoder.configure(lookup: :test, ip_lookup: :test)
  Geocoder::Lookup::Test.set_default_stub(
      [
          {
              'coordinates'  => [33.122424, -117.3068415],
              'address'      => 'Carlsbad, CA, USA',
              'state'        => 'Carlsbad',
              'state_code'   => 'CA',
              'country'      => 'United States',
              'country_code' => 'US'
          }
      ]
  )
else
  Geocoder.configure(lookup: :geocoder_ca, timeout: 5)
end
