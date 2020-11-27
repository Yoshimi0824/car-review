FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    phone_number {Faker::Number.number(digits: 11) }
    birthday { Faker::Date.between(from: '1930-01-01', to: Date.today) }
  end
end