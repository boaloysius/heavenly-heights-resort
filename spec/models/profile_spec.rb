# spec/models/profile_spec.rb

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:fullName) }

    it 'validates the presence of country if country is present' do
      profile = Profile.new(fullName: 'John Doe', country: 'Albania', user: user)
      expect(profile).to be_valid
    end

    it 'does not validate the presence of country if country is not present' do
      profile = Profile.new(fullName: 'John Doe', user: user)
      expect(profile).to be_valid
    end

    it 'validates country if present' do
      profile = Profile.new(fullName: 'John Doe', country: 'InvalidCountry', user: user)
      expect(profile).not_to be_valid
      expect(profile.errors[:country]).to include('is not in the list')
    end
  end

  describe '#profile_complete?' do
    it 'returns true if fullName, country, and nationalID are present' do
      profile = Profile.new(fullName: 'John Doe', country: 'Albania', nationalID: '123456', user: user)
      expect(profile.profile_complete?).to be true
    end

    it 'returns false if fullName is missing' do
      profile = Profile.new(country: 'Albania', nationalID: '123456', user: user)
      expect(profile.profile_complete?).to be false
    end

    it 'returns false if country is missing' do
      profile = Profile.new(fullName: 'John Doe', nationalID: '123456', user: user)
      expect(profile.profile_complete?).to be false
    end

    it 'returns false if nationalID is missing' do
      profile = Profile.new(fullName: 'John Doe', country: 'Albania', user: user)
      expect(profile.profile_complete?).to be false
    end
  end

  describe 'callbacks' do
    it 'sets countryFlag before saving if country is present and valid' do
      profile = Profile.new(fullName: 'John Doe', country: 'Albania', user: user)
      profile.save
      expect(profile.countryFlag).to eq('https://flagcdn.com/al.svg')
    end

    it 'does not set countryFlag if country is not present' do
      profile = Profile.new(fullName: 'John Doe', user: user)
      profile.save
      expect(profile.countryFlag).to be_nil
    end

    it 'does not set countryFlag if country is not valid' do
      profile = Profile.new(fullName: 'John Doe', country: 'InvalidCountry', user: user)
      profile.save
      expect(profile.countryFlag).to be_nil
    end
  end
end
