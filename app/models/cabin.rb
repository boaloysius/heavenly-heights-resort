class Cabin < ApplicationRecord
  has_one_attached :imageFile

  validates :maxCapacity, presence: true
  validates :regularPrice, presence: true
  validates :name, presence: true,  uniqueness: true
  # validate :imageFile_attached
  validates :description, presence: true

  validate :discount_less_than_regular_price
  validate :acceptable_image

  def imageUrl
    Rails.application.routes.url_helpers.url_for(imageFile) if imageFile.attached?
  end

  private

  def discount_less_than_regular_price
    return if regularPrice.nil? || discount.nil?

    if discount >= regularPrice
      errors.add(:discount, "must be less than the regular price")
    end
  end

  # def imageFile_attached
  #   errors.add(:imageFile, "can't be blank") unless imageFile.attached?
  # end  

  def acceptable_image
    return unless imageFile.attached?

    unless imageFile.blob.byte_size <= 5.megabytes
      return errors.add(:imageFile, "is too big. Maximum size allowed is 5MB.")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(imageFile.blob.content_type)
      return errors.add(:imageFile, "must be a JPEG or PNG.")
    end
  end
end
