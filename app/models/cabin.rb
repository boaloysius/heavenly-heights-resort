class Cabin < ApplicationRecord
  # self.primary_key = 'uuid'

  validates :maxCapacity, presence: true
  validates :regularPrice, presence: true
  validates :name, presence: true,  uniqueness: true
  validates :image, presence: true
  validates :description, presence: true

  validate :discount_less_than_regular_price

  private

  def discount_less_than_regular_price
    return if regularPrice.nil? || discount.nil?

    if discount >= regularPrice
      errors.add(:discount, "must be less than the regular price")
    end
  end
end
