FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { "9.99" }
    quantity { 1 }
    describtion { "MyText" }
    category { "MyString" }
    material { "MyString" }
    manufacturing_method { "MyString" }
    country { "MyString" }
    content { "MyText" }
  end
end
