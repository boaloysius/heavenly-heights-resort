# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
      can [:create, :update, :destroy], Cabin
      can :bookings, Profile
    else
      can :read, Booking, user_id: user.id
      can [:create, :update, :destroy], Booking, user_id: user.id
      can :read, Cabin
      can :bookings, Profile, user_id: user.id
    end
  end
end
