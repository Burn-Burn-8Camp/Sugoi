FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Number.within(range: 100..1000) }
    quantity { Faker::Number.within(range: 1..100) }
  end
end
