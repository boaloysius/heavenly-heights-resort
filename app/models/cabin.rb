class Cabin < ApplicationRecord
  has_many :bookings, dependent: :restrict_with_error

  validates :maxCapacity, presence: true
  validates :regularPrice, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  validate :discount_less_than_regular_price

  after_initialize :set_default_image_url, if: :new_record?

  def upload_image(image_file)
    result = Cloudinary::Uploader.upload(image_file, folder: 'heavenly-heights/cabins')
    self.imagePublicId = result["public_id"]
    self.imageUrl = result["secure_url"]
  end
  

  def set_default_image_url
    return if self.imageUrl
    
    self.imageUrl ||= 'https://res.cloudinary.com/dudulqvif/image/upload/v1724175365/dummy_cabin.jpg'
    self.imagePublicId = 'dummy_cabin'
  end

  private

  def discount_less_than_regular_price
    return if regularPrice.nil? || discount.nil?

    if discount >= regularPrice
      errors.add(:discount, "must be less than the regular price")
    end
  end
end
