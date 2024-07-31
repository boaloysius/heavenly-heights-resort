class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  has_many :bookings

  devise :database_authenticatable, :registerable, 
        :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :profile, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  
  validate :profile_attributes_presence
  validates_associated :profile

  accepts_nested_attributes_for :profile

  private
  def profile_attributes_presence
    if new_record? && profile.blank?
      errors.add(:profile, "must be provided")
    end
  end
end
