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
  end
end
