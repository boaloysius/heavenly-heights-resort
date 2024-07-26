module BookingConstants
  extend ActiveSupport::Concern

  included do
    MINIMUM_BOOKING_LENGTH = 4
    MAXIMUM_BOOKING_LENGTH = 30
    MAXIMUM_GUESTS_PER_BOOKING = 15
    BREAKFAST_PRICE = 20
  end
end