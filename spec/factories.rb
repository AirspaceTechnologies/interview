FactoryGirl.define do
  factory :address do
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    full_address do
      "#{Faker::Address.street_address},#{Faker::Address.city},#{Faker::Address.state_abbr} #{Faker::Address.zip}"
    end

    trait :as_detroit do
      full_address '5736 Rosa Parks Boulevard,Detroit,MI 48208'
      lat 42.357466
      lng -83.085961
    end

    trait :as_kansas_city do
      full_address '2704 Harrison Street,Kansas City,MO 64109'
      lat 39.077531
      lng -94.572519
    end

    trait :as_white_house do
      full_address '1600 Pennsylvania Avenue NW Washington, D.C. 20500 USA'
      lat 38.8976633
      lng -77.0365739
    end
  end
end
