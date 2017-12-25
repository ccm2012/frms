class Ability
  include CanCan::Ability

  def initialize user
    case user
    when Staff
      if user.administrator?
        can :manage, Staff
      elsif user.chef?
        chef_role
      else
        receptionist_role
      end
    when User
      can :show, :all
    end
  end

  def chef_role
    can :read, Staff
  end

  def receptionist_role
    can :read, Staff
  end
end
