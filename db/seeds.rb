require 'faker'

# Create an admin user
admin_user = User.create!(
  email: 'admin-1@gmail.com',
  password: 'Password@123',
  role: 'admin',
  profile_attributes: {
    fullName: 'Admin one',
    country: 'Australia',
    nationalID: 'qwezd123',
    imagePublicId: "admin-1",
    imageUrl: "https://res.cloudinary.com/dudulqvif/image/upload/v1724264719/admin-1"    
  }
)

# Create a client user
client_user1 = User.create!(
  email: 'client-1@gmail.com',
  password: 'Password@123',
  role: 'client',
  profile_attributes: {
    fullName: 'client one',
    country: 'India',
    nationalID: 'qwezd123',
    imagePublicId: "client-1",
    imageUrl: "https://res.cloudinary.com/dudulqvif/image/upload/v1724264719/client-1"
  }
)

client_user2 = User.create!(
  email: 'client-2@gmail.com',
  password: 'Password@123',
  role: 'client',
  profile_attributes: {
    fullName: 'client two',
    country: 'India',
    nationalID: 'qwezd123',
    imagePublicId: "client-2",
    imageUrl: "https://res.cloudinary.com/dudulqvif/image/upload/v1724929652/client-2"
  }
)

client_user3 = User.create!(
  email: 'client-3@gmail.com',
  password: 'Password@123',
  role: 'client',
  profile_attributes: {
    fullName: 'client three',
    country: 'India',
    nationalID: 'qwezd123',
    imagePublicId: "client-3",
    imageUrl: "https://res.cloudinary.com/dudulqvif/image/upload/v1724929651/client-3"
  }
)

puts "Created admin user: #{admin_user.email}" if admin_user.persisted?
puts "Created client user 1: #{client_user1.email}" if client_user1.persisted?
puts "Created client user 2: #{client_user2.email}" if client_user2.persisted?
puts "Created client user 3: #{client_user3.email}" if client_user3.persisted?

8.times do |i|
  max_capacity = Faker::Number.between(from: 3, to: 8)

  # Calculate price based on capacity with a range from 100 to 3000
  min_price = 100
  max_price = 3000
  price_range = max_capacity * (max_price - min_price) / 10  # Scale price with capacity

  regular_price = min_price + price_range
  regular_price = [regular_price, max_price].min  # Ensure price does not exceed max_price

  # Generate image data
  image_public_id = format('cabin-%03d-1', i + 1)
  image_url = format('https://res.cloudinary.com/dudulqvif/image/upload/v1725282060/cabin-%03d', i + 1)
  
  # Define cabin descriptions
  descriptions = [
    "Cabin 001 is a serene and charming retreat that offers a perfect escape into nature's embrace. Nestled amidst lush greenery, this cozy cabin provides stunning, uninterrupted mountain views that create a peaceful and enchanting atmosphere. The interior is thoughtfully designed to ensure maximum comfort and relaxation. It features a luxurious queen-sized bed with high-quality linens, ideal for a restful night after a day of exploring the beautiful surroundings. The cabin includes a well-equipped kitchenette with essential appliances such as a compact refrigerator, microwave, and coffee maker, making it convenient to prepare simple meals or enjoy a hot drink.",
  
    "Cabin 002 is an inviting and spacious two-bedroom retreat designed for families or groups of friends seeking a comfortable and memorable escape. Surrounded by vibrant flowers and lush trees, this cabin offers a picturesque and serene environment that enhances your stay. The open-plan living area is thoughtfully arranged to create a welcoming and functional space, perfect for gathering with loved ones. The cabin features comfortable furnishings and a well-equipped kitchen, complete with modern appliances and ample counter space, allowing you to prepare and enjoy meals together. ",
  
    "Cabin 003 is a luxurious retreat that combines elegance and comfort, making it an ideal choice for larger groups or families. With three well-appointed bedrooms, a grand living area, and a modern kitchen, this cabin provides ample space and upscale amenities for a relaxing and enjoyable stay. The modern kitchen is fully equipped with high-end appliances and generous counter space, making it easy to prepare meals and entertain guests. The expansive living area is designed for comfort and style, featuring stylish furnishings and a warm ambiance that encourages relaxation. ",
  
    "Cabin 004 is a spacious and well-designed retreat, perfect for family gatherings or group getaways. With four bedrooms and ample living space, this cabin accommodates larger groups comfortably and provides a welcoming environment for relaxation and socializing. The wrap-around porch is a standout feature, offering panoramic views of the surrounding landscape and providing a perfect spot for unwinding or entertaining. Inside, the cabin combines rustic charm with modern comforts, featuring a thoughtfully designed open-plan living area with comfortable furnishings and a well-equipped kitchen. ",
  
    "Cabin 005 offers a charming and cozy retreat with its five well-appointed bedrooms and inviting interiors. The cabin is designed to provide a comfortable and homely atmosphere, making it an ideal choice for families or groups seeking a relaxing getaway. The large deck is a key feature, offering ample space for outdoor dining and enjoying the beautiful natural surroundings of Munnar. The cabin’s interior is thoughtfully furnished with comfortable seating and well-equipped living spaces, ensuring that guests feel at ease throughout their stay. ",
  
    "Cabin 006 is a luxurious six-bedroom retreat that offers an exceptional level of comfort and sophistication. The cabin features elegant decor and expansive living spaces, designed to provide a high-end experience for guests seeking both relaxation and indulgence. The hot tub on the terrace is a standout feature, offering a luxurious way to unwind while enjoying panoramic views of the surrounding landscape. The home theater system adds an extra touch of entertainment, allowing guests to enjoy movies or shows in a comfortable and stylish setting.",
  
    "Cabin 007 is a stunning seven-bedroom lodge that offers a perfect blend of luxury and functionality. The cabin is equipped with a swimming pool, sun deck, and outdoor kitchen, making it an excellent choice for hosting events or large gatherings. The beautifully landscaped garden and spacious interiors provide a refined setting for special occasions, allowing guests to enjoy both comfort and elegance. The cabin’s design emphasizes versatility and high-end features, ensuring that your stay is both luxurious and memorable.",
  
    "Cabin 008 is an eight-bedroom masterpiece that embodies unparalleled elegance and sophistication. With multiple living areas, a state-of-the-art kitchen, and an infinity pool, this cabin is designed to accommodate large groups or host special events. The luxurious decor and breathtaking views create an unforgettable experience, ensuring that every guest enjoys the height of comfort and style. The cabin’s expansive layout provides ample space for both relaxation and entertainment, making it ideal for significant gatherings or lavish retreats."
  ]

  cabin = Cabin.create(
    maxCapacity: max_capacity,
    regularPrice: regular_price,
    discount: Faker::Number.between(from: 0, to: 50),
    name: format('%03d', i + 1),  # Sequential name with leading zeros
    description: descriptions[i],
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

# Create bookings

booking_details = [
  { 
    start_date: "2024-08-01", 
    end_date: "2024-08-06", 
    num_guests: Cabin.first.maxCapacity - 1, 
    cabin_id: Cabin.first.id,
    observations: "Requesting early check-in.", 
    is_paid: true, 
    status: "checkedout", 
    user_id: client_user1.id,
    has_breakfast: true
  },
  { 
    start_date: "2024-08-07", 
    end_date: "2024-08-10", 
    num_guests: Cabin.first.maxCapacity - 1, 
    cabin_id: Cabin.first.id,
    observations: "Requesting early check-in.", 
    is_paid: true, 
    status: "checkedout", 
    user_id: client_user1.id,
    has_breakfast: false
  },
  { 
    start_date: "2024-08-01", 
    end_date: "2024-08-06", 
    num_guests: Cabin.second.maxCapacity - 1, 
    cabin_id: Cabin.second.id,
    observations: "Requesting early check-in.", 
    is_paid: false, 
    status: "booked", 
    user_id: client_user2.id,
    has_breakfast: true
  },
  { 
    start_date: "2024-08-07", 
    end_date: "2024-08-10", 
    num_guests: Cabin.second.maxCapacity - 1, 
    cabin_id: Cabin.second.id,
    observations: "Requesting early check-in.", 
    is_paid: false, 
    status: "confirmed", 
    user_id: client_user2.id,
    has_breakfast: false
  },    
  { 
    start_date: "2024-10-01", 
    end_date: "2024-10-05", 
    num_guests: Cabin.first.maxCapacity - 1, 
    cabin_id: Cabin.first.id,
    observations: "Requesting early check-in.", 
    is_paid: false, 
    status: "booked", 
    user_id: client_user1.id,
    has_breakfast: true
  },
  { 
    start_date: "2024-10-01", 
    end_date: "2024-10-02", 
    num_guests: Cabin.second.maxCapacity - 1, 
    cabin_id: Cabin.second.id,
    observations: "Requesting early check-in.", 
    is_paid: true, 
    status: "confirmed", 
    user_id: client_user2.id,
    has_breakfast: true
  },    
  { 
    start_date: "2024-11-01", 
    end_date: "2024-11-04", 
    num_guests: Cabin.first.maxCapacity - 1, 
    cabin_id: Cabin.first.id,
    observations: "Requesting early check-in.", 
    is_paid: false, 
    status: "booked", 
    user_id: client_user1.id,
    has_breakfast: true
  },
  { 
    start_date: "2024-11-01", 
    end_date: "2024-11-03", 
    num_guests: Cabin.second.maxCapacity - 1, 
    cabin_id: Cabin.second.id,
    observations: "Requesting early check-in.", 
    is_paid: true, 
    status: "confirmed", 
    user_id: client_user2.id,
    has_breakfast: true
  }
]

booking_details.each do |details|
  booking = Booking.create(
    start_date: details[:start_date],
    end_date: details[:end_date],
    num_guests: details[:num_guests],
    observations: details[:observations],
    is_paid: details[:is_paid],
    status: details[:status],
    has_breakfast: details[:has_breakfast],
    cabin_id: details[:cabin_id],
    user_id: details[:user_id]
  )

  if booking.save
    puts "Created booking for user #{booking.user_id} in cabin #{booking.cabin_id}"
  else
    puts "Failed to create booking for user #{details[:user_id]}: #{booking.errors.full_messages.join(', ')}"
  end
end
