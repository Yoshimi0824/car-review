FactoryBot.define do
  factory :review do
    automaker_id { Faker::Number.between(from: 1, to: 10) }
    model_of_car { Faker::Vehicle.model }
    grade { Faker::Vehicle.style }
    era_name_id { Faker::Number.between(from: 1, to: 4) }
    model_year { Faker::Number.between(from: 1, to: 99) }
    design_id { Faker::Number.between(from: 1, to: 5) }
    driving_performance_id { Faker::Number.between(from: 1, to: 5) }
    ride_comfort_id { Faker::Number.between(from: 1, to: 5) }
    lording_id { Faker::Number.between(from: 1, to: 5) }
    fuel_economy_id { Faker::Number.between(from: 1, to: 5) }
    price_id { Faker::Number.between(from: 1, to: 5) }
    good_point { Faker::Lorem.sentences }
    bad_point { Faker::Lorem.sentences }
    association :user


    after(:build) do |message|
      message.image.attach(io: File.open('public/images/carsample2.png'), filename: 'carsample2.png')
    end
  end
end