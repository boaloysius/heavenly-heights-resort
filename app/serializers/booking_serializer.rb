# app/serializers/booking_serializer.rb
class BookingSerializer
  include JSONAPI::Serializer

  attributes :id, :num_nights, :num_guests, 
             :cabin_price, :extras_price, :total_price, :has_breakfast, 
             :is_paid, :status, :observations

  attribute :user_profile do |booking|
    ProfileSerializer.new(booking.user.profile).serializable_hash[:data][:attributes]
  end  

  attribute :cabin do |booking|
    CabinSerializer.new(booking.cabin).serializable_hash[:data][:attributes]
  end    

  attribute :start_date do |booking|
    booking.start_date.strftime('%Y-%m-%d')
  end

  attribute :end_date do |booking|
    booking.end_date.strftime('%Y-%m-%d')
  end
end
