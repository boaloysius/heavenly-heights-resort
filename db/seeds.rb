require 'faker'

10.times do |i|
  max_capacity = Faker::Number.between(from: 1, to: 10)

  # Calculate price based on capacity with a range from 100 to 3000
  min_price = 100
  max_price = 3000
  price_range = max_capacity * (max_price - min_price) / 10  # Scale price with capacity

  regular_price = min_price + price_range
  regular_price = [regular_price, max_price].min  # Ensure price does not exceed max_price

  cabin = Cabin.create(
    maxCapacity: max_capacity,
    regularPrice: regular_price,
    discount: Faker::Number.between(from: 0, to: 50),
    name: format('%03d', i + 1),  # Sequential name with leading zeros
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )

  # Attach an image to the cabin
  cabin.imageFile.attach(
    io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_cabin_image.jpg')),
    filename: 'sample_cabin_image.jpg',
    content_type: 'image/jpeg'
  )

  # Debug output
  if cabin.save
    puts "Created cabin #{cabin.name} with ID #{cabin.id}"
  else
    puts "Failed to create cabin #{cabin.name}: #{cabin.errors.full_messages.join(', ')}"
  end

  # Attach an image to the cabin
  # cabin.imageFile.attach(
  #   io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_cabin_image.jpg')),
  #   filename: 'sample_cabin_image.jpg',
  #   content_type: 'image/jpeg'
  # ) if cabin.persisted?
end
