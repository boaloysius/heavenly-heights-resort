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

  before_validation :capitalize_full_name # Add this line
  before_save :set_country_flag  
  after_initialize :set_default_image_url, if: :new_record?

  def profile_complete?
    fullName.present? && country.present? && nationalID.present?
  end

  def upload_image(image_file)
    result = Cloudinary::Uploader.upload(image_file, folder: 'heavenly-heights/profiles')
    self.imagePublicId = result["public_id"]
    self.imageUrl = result["secure_url"]
  end

  def set_default_image_url
    return if self.imageUrl
    
    self.imageUrl ||= 'https://res.cloudinary.com/dudulqvif/image/upload/v1724220169/profile_avatar.avif'
    self.imagePublicId = 'profile_avatar'
  end  

  private

  def capitalize_full_name
    self.fullName = fullName.split.map(&:capitalize).join(' ') if fullName.present?
  end

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
