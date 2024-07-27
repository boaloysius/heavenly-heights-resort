class ProfileSerializer
  include JSONAPI::Serializer
  attributes :id, :fullName, :nationalID, :country, :countryFlag, :created_at
  attribute :profile_complete do |profile|
    profile.profile_complete?
  end
  attribute :email do |profile|
    profile.user.email
  end  
end
