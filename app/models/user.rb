class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, 
        :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :profile, dependent: :destroy
        
  validates :email, presence: true, uniqueness: true

  accepts_nested_attributes_for :profile

  after_create :create_profile

  def create_profile
    Profile.create(user: self)
  end
end
