class ProfileSerializer
  include JSONAPI::Serializer
  attributes :fullName, :nationalID, :country, :countryFlag, :created_at
  attribute :profile_complete do |profile|
    profile.profile_complete?
  end
  attribute :email do |profile|
    profile.user.email
  end
  attribute :user_id do |profile|
    profile.user.id
  end
  attribute :role do |profile|
    profile.user.role
  end
end
