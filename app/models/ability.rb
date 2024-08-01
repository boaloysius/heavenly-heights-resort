class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
      can [:create, :update, :destroy], Cabin
    else
      can :read, Booking, user_id: user.id
      can [:create, :update, :destroy], Booking, user_id: user.id
      can :read, Cabin
    end
  end
end
