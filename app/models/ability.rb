class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, User
    else
      can :read, User
      can :index, User
    end
    # if logged_in_user
    #   can :edit, User
    #   can :update, User
    #   can :index, User
    #   can :destroy, User
    #   can :following, User
    #   can :followers, User
    # end
  end
end
