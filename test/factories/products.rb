FactoryBot.define do
  factory :product do
    store_id {Faker::Number.within(range: 1..3)}
    name { Faker::Book.title }
    price { Faker::Number.within(range: 100..1000) }
    quantity { Faker::Number.within(range: 1..50) }
    description { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true) }
    category {["food", "book", "movie", "animal", "dragonBall"].sample}
  end
end
