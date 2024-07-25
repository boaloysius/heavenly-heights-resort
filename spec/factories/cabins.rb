FactoryBot.define do
  factory :cabin do
    maxCapacity { Faker::Number.between(from: 1, to: 10) }
    regularPrice { Faker::Number.between(from: 100, to: 3000) }
    discount { Faker::Number.between(from: 0, to: 99) }
    sequence(:name) { |n| "#{n.to_s.rjust(3, '0')}" }
    image { Faker::LoremFlickr.image(size: "500x500", search_terms: ['luxury', 'hotel']) }
    description { Faker::Lorem.sentence }
  end
end
