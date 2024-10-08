module BookingConstants
  extend ActiveSupport::Concern

  MINIMUM_BOOKING_LENGTH = 2
  MAXIMUM_BOOKING_LENGTH = 30
  MAXIMUM_GUESTS_PER_BOOKING = 15
  BREAKFAST_PRICE = 20

  # Define constants for booking statuses
  BOOKED_STATUS = 'booked'
  CONFIRMED_STATUS = 'confirmed'
  CHECKEDIN_STATUS = 'checkedin'
  CHECKEDOUT_STATUS = 'checkedout'

  # Define an array of all possible statuses
  STATUSES = [BOOKED_STATUS, CONFIRMED_STATUS, CHECKEDIN_STATUS, CHECKEDOUT_STATUS].freeze
end
