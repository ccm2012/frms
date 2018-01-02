class Ability
  include CanCan::Ability

  def initialize user
    case user
    when Staff
      if user.administrator?
        can :manage, Staff
        can :manage, Customer
        can :manage, Dish
      elsif user.chef?
        chef_role
      else
        receptionist_role
      end
    when Customer
      can :show, :all
    end
  end

  def chef_role
    can :read, Staff
    can :manage, Dish
  end

  def receptionist_role
    can :read, Staff
    can :manage, Customer
  end
end
