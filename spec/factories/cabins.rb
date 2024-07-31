FactoryBot.define do
  factory :cabin do
    maxCapacity { Faker::Number.between(from: 1, to: 10) }
    regularPrice { Faker::Number.between(from: 100, to: 3000) }
    discount { Faker::Number.between(from: 0, to: 99) }
    sequence(:name) { |n| "#{n.to_s.rjust(3, '0')}" }
    description { Faker::Lorem.sentence }
    
    # TODO: https://github.com/boaloysius/heavenly-heights-resort/issues/25
    
    # after(:build) do |cabin|
    #   cabin.imageFile.attach(
    #     io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_cabin_image.jpg')),
    #     filename: 'sample_cabin_image.jpg',
    #     content_type: 'image/jpeg'
    #   )
    # end
  end
end
