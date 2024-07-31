# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:profile).dependent(:destroy) }
  it { should have_many(:bookings) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  describe 'after_create callback' do
    it 'creates a profile with valid attributes' do
      user = User.create(email: 'test@example.com', password: 'password123', profile_attributes: { fullName: 'John Doe', country: 'Albania' })
      expect(user.profile).to be_present
      expect(user.profile.fullName).to eq('John Doe')
      expect(user.profile.country).to eq('Albania')
    end

    it 'does not create a user if profile is invalid' do
      expect {
        User.create!(email: 'test@example.com', password: 'password123', profile_attributes: { country: 'InvalidCountry' })
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not create a user if profile_attributes are not passed' do
      user = User.create(email: 'test@example.com', password: 'password123')
      expect(user.errors[:profile]).to include("must be provided")
    end

    it 'does not create a user if profile fullName is missing' do
      user = User.create(email: 'test@example.com', password: 'password123', profile_attributes: { country: 'Albania' })
      expect(user.errors[:profile]).to include("is invalid")
      expect(user.errors.full_messages).to include("Profile fullname can't be blank")
    end

    it 'does not create a user if profile country is invalid' do
      user = User.create(email: 'test@example.com', password: 'password123', profile_attributes: { fullName: 'John Doe', country: 'InvalidCountry' })
      expect(user.errors[:profile]).to include("is invalid")
      expect(user.errors.full_messages).to include("Profile country is not in the list")
    end   
  end
end
