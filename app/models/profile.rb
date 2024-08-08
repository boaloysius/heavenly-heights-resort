class Profile < ApplicationRecord
  include ProfileConcern
  
  belongs_to :user

  # Full name validation
  validates :fullName, presence: true, length: { in: 3..20 }, format: { 
    with: /\A[a-zA-Z\s]+\z/, 
    message: "can only contain letters and spaces." 
  }

  validates :country, presence: true, if: :country_present?
  validate :validate_country, if: :country_present?

  def profile_complete?
    fullName.present? && country.present? && nationalID.present?
  end

  before_save :set_country_flag  

  private

  def country_present?
    country.present?
  end

  def validate_country
    errors.add(:country, 'is not in the list') unless valid_country?(country)
  end

  def set_country_flag
    self.countryFlag = flag_for_country(country) if country.present? && valid_country?(country)
  end  
end
