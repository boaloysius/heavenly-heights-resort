class Booking < ApplicationRecord
  include BookingConstants

  belongs_to :user
  belongs_to :cabin

  # Validations
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :num_guests, presence: true
  validates :cabin_id, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  validates :num_guests, numericality: { greater_than: 0, less_than_or_equal_to: MAXIMUM_GUESTS_PER_BOOKING }

  validate :end_date_after_start_date
  validate :num_guests_within_capacity
  validate :num_dates_within_limits
  validate :cabin_does_not_have_overlapping_bookings

  before_validation :set_num_dates
  before_validation :calculate_prices

  # Set default status
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= BOOKED_STATUS
  end

  def set_num_dates
    return unless start_date.present? && end_date.present?

    self.num_dates = (end_date.to_date - start_date.to_date).to_i + 1
  end

  def calculate_prices
    return unless cabin.present? && num_dates.present?

    one_day_price = cabin.regularPrice - (cabin.discount || 0)
    self.cabin_price = one_day_price * num_dates
    self.extras_price = BREAKFAST_PRICE * num_dates
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

  def num_dates_within_limits
    return unless num_dates.present?

    if num_dates < MINIMUM_BOOKING_LENGTH || num_dates > MAXIMUM_BOOKING_LENGTH
      errors.add(:num_dates, "must be between #{MINIMUM_BOOKING_LENGTH} and #{MAXIMUM_BOOKING_LENGTH} nights")
    end
  end

  def cabin_does_not_have_overlapping_bookings
    return unless cabin.present? && start_date.present? && end_date.present?

    overlapping_bookings = Booking.where(cabin_id: cabin.id)
                                  .where.not(id: id)
                                  .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    if overlapping_bookings.exists?
      errors.add(:dates, "have overlapping bookings for the cabin")
    end
  end
end
