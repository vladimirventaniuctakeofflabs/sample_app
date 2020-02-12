class Ability
  include CanCan::Ability
  include SessionsHelper
  def initialize(user)
    if user == nil
      cannot :edit, User
      cannot :update, User
      cannot :index, User 
      cannot :destroy, User
      cannot :following, User
      cannot :followers, User
      can :new, User
      can :create, User
    else
      can :new, User
      can :create, User
      can [:create, :destroy], Micropost
      can :destroy, Micropost do |cmicropost|
        @micropost = user.microposts.find_by(cmicropost.id.to_s)
        @micropost == cmicropost    
      end
      if user.is_admin?
        can :manage, User
      else
        can :read, User
        can :index, User
        can :following, User
        can :followers, User
        can :update, User do |cuser|
            user.id == cuser.id
        end
      end
    end
  
  
  end
end
