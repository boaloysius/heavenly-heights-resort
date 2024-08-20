require 'faker'

8.times do |i|
  max_capacity = Faker::Number.between(from: 1, to: 8)

  # Calculate price based on capacity with a range from 100 to 3000
  min_price = 100
  max_price = 3000
  price_range = max_capacity * (max_price - min_price) / 10  # Scale price with capacity

  regular_price = min_price + price_range
  regular_price = [regular_price, max_price].min  # Ensure price does not exceed max_price

  # Generate image data
  image_public_id = format('cabin-%03d', i + 1)
  image_url = format('https://res.cloudinary.com/dudulqvif/image/upload/v1724170157/cabin-%03d', i + 1)
  

  cabin = Cabin.create(
    maxCapacity: max_capacity,
    regularPrice: regular_price,
    discount: Faker::Number.between(from: 0, to: 50),
    name: format('%03d', i + 1),  # Sequential name with leading zeros
    description: Faker::Lorem.paragraph(sentence_count: 20),
    imageUrl: image_url,
    imagePublicId: image_public_id
  )

  # Debug output
  if cabin.save
    puts "Created cabin #{cabin.name} with ID #{cabin.id}"
  else
    puts "Failed to create cabin #{cabin.name}: #{cabin.errors.full_messages.join(', ')}"
  end

end
