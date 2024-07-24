class Cabin < ApplicationRecord
  validates :maxCapacity, presence: true
  validates :regularPrice, presence: true
  validates :name, presence: true,  uniqueness: true
  validates :image, presence: true
  validates :description, presence: true

  validate :discount_less_than_regular_price

  private

  def discount_less_than_regular_price
    if discount > regularPrice
      errors.add(:discount, "must be less than or equal to the regular price")
    end
  end  
end
