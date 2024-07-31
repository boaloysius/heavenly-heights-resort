# spec/models/booking_spec.rb

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:user) { User.create(
    email: 'test@example.com', 
    password: 'password123', 
    profile_attributes: { 
      fullName: 'John Doe', 
      country: 'Albania' 
      }
    ) 
  }

  let(:cabin) { Cabin.create(
    maxCapacity: 10,
    regularPrice: 200,
    discount: 10,
    name: "Test cabin",
    description: "Test description",
    )
  }

  subject do
    described_class.new(
      user: user,
      cabin: cabin,
      start_date: Date.today,
      end_date: Date.today + 2.days,
      num_guests: 2,
      status: 'confirmed'
    )
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:cabin) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:num_guests) }
    it { should validate_presence_of(:cabin_id) }
    it { should validate_presence_of(:status) }

    it { should validate_numericality_of(:num_guests).is_greater_than(0).is_less_than_or_equal_to(BookingConstants::MAXIMUM_GUESTS_PER_BOOKING) }

    describe 'custom validations' do
      it 'validates end_date is after start_date' do
        subject.end_date = subject.start_date - 1.day
        expect(subject).not_to be_valid
        expect(subject.errors[:end_date]).to include('must be after the start date')
      end

      it 'validates num_guests does not exceed cabin capacity' do
        subject.num_guests = cabin.maxCapacity + 1
        expect(subject).not_to be_valid
        expect(subject.errors[:num_guests]).to include("cannot exceed the cabin's maximum capacity of #{cabin.maxCapacity}")
      end

      it 'validates num_nights is within limits' do
        subject.start_date = Date.today
        subject.end_date = Date.today + (BookingConstants::MAXIMUM_BOOKING_LENGTH + 1).days
        subject.valid?
        expect(subject.errors[:num_nights]).to include("must be between #{BookingConstants::MINIMUM_BOOKING_LENGTH} and #{BookingConstants::MAXIMUM_BOOKING_LENGTH} nights")
      end

      it 'validates cabin does not have overlapping bookings' do
        existing_booking = Booking.create(
          user: user,
          cabin: cabin,
          start_date: Date.today,
          end_date: Date.today + 5.days,
          num_guests: 2,
          status: 'confirmed',
          num_nights: 2,
          has_breakfast: false,
          is_paid: false
        )

        new_booking = described_class.new(
          user: user,
          cabin: cabin,
          start_date: Date.today + 2.day,
          end_date: Date.today + 7.days,
          num_guests: 2,
          status: 'confirmed',
          has_breakfast: false,
          is_paid: false
        )
        new_booking.valid?
        p new_booking.errors
        expect(new_booking.errors[:base]).to include('The cabin has overlapping bookings for the selected dates')
      end
    end
  end

  describe 'callbacks' do
    it 'sets num_nights before validation' do
      subject.valid?
      expect(subject.num_nights).to eq(2)
    end

    it 'calculates prices before validation' do
      subject.valid?
      expect(subject.cabin_price).to eq((cabin.regularPrice - (cabin.discount || 0)) * subject.num_nights)
      expect(subject.extras_price).to eq(BookingConstants::BREAKFAST_PRICE * subject.num_nights)
      expect(subject.total_price).to eq(subject.cabin_price + subject.extras_price)
    end
  end
end
