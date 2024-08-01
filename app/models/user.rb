class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %w[admin client].freeze
  
  has_many :bookings

  devise :database_authenticatable, :registerable, 
        :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :profile, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  
  validate :profile_attributes_presence
  validates_associated :profile

  validates :role, presence: true, inclusion: { in: ROLES }

  accepts_nested_attributes_for :profile

  def admin?
    role == 'admin'
  end

  def client?
    role == 'client'
  end

  private
  def profile_attributes_presence
    if new_record? && profile.blank?
      errors.add(:profile, "must be provided")
    end
  end
end
