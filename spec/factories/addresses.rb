FactoryBot.define do
  factory :address do
    postal_code {'111-1111'}
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    municipality { Gimei.address.city.kanji }
    street_number { Gimei.address.town.kanji }
    building_name { 'マンション名' }
  end
end