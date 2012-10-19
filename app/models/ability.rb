class Ability
  include CanCan::Ability


  # This method is used later for encapsulating the admin module
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can [:new, :create], Group
    can [:new, :create], User
    
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :group_admin
      can :manage, Group, :group_id => user.group_ids
      
      can [:new, :create], Event
      can [:index, :show, :add_entry, :remove_entry, :get_by_date], Event, :group_id => user.group_ids
      can [:edit, :update, :destroy], Event, :organizer => user.id
      
      can [:index, :show, :create] 
    elsif user.has_role? :
      can [:show], Group, :group_id => user.group_ids
      can [:new, :create], Event
      can [:index, :show, :add_entry, :remove_entry, :get_by_date], Event, :group_id => user.group_ids
      can [:edit, :update, :destroy], Event, :organizer => user.id
    end
  end
end
