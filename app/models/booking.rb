class Booking < ApplicationRecord
  include BookingConstants

  belongs_to :user
  belongs_to :cabin

  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :num_guests, presence: true
  validates :cabin_id, presence: true
  validates :status, presence: true

  validates :num_guests, numericality: { greater_than: 0, less_than_or_equal_to: MAXIMUM_GUESTS_PER_BOOKING }

  validate :end_date_after_start_date
  validate :num_guests_within_capacity
  validate :num_nights_within_limits
  validate :cabin_does_not_have_overlapping_bookings

  before_validation :set_num_nights
  before_validation :calculate_prices

  private

  def set_num_nights
    return unless start_date.present? && end_date.present?

    self.num_nights = (end_date.to_date - start_date.to_date).to_i
  end

  def calculate_prices
    return unless cabin.present? && num_nights.present?

    one_day_price = cabin.regularPrice - (cabin.discount || 0)
    self.cabin_price = one_day_price * num_nights
    self.extras_price = BREAKFAST_PRICE * num_nights
    self.total_price = cabin_price + extras_price
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def num_guests_within_capacity
    return unless cabin.present?

    if num_guests && (num_guests > cabin.maxCapacity)
      errors.add(:num_guests, "cannot exceed the cabin's maximum capacity of #{cabin.maxCapacity}")
    end
  end

  def num_nights_within_limits
    return unless num_nights.present?

    if num_nights < MINIMUM_BOOKING_LENGTH || num_nights > MAXIMUM_BOOKING_LENGTH
      errors.add(:num_nights, "must be between #{MINIMUM_BOOKING_LENGTH} and #{MAXIMUM_BOOKING_LENGTH} nights")
    end
  end

  def cabin_does_not_have_overlapping_bookings
    return unless cabin.present? && start_date.present? && end_date.present?

    overlapping_bookings = Booking.where(cabin_id: cabin.id)
                                  .where.not(id: id) # Exclude current booking if it's an update
                                  .where("start_date < ? AND end_date > ?", end_date, start_date)

    if overlapping_bookings.exists?
      errors.add(:base, "The cabin has overlapping bookings for the selected dates")
    end
  end  
end
