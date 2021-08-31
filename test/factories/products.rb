FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Number.within(range: 100..1000) }
    quantity { 1 }
    describtion { Faker::Lorem.paragraph(sentence_count: 4) }
    category { "MyString" }
    material { "MyString" }
    manufacturing_method { "MyString" }
    country { Faker::Nation.nationality }
    content { "MyText" }
  end
end
