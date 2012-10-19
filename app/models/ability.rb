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
      can :manage, DirectMessage
      
      can [:new, :create], Discussion
      can [:index, :show], Discussion, :group_id => user.group_ids
      can [:edit, :update, :destroy], Discussion, :user_id => user.id
      
      discussions = Discussion.where(:group_id => user.group_ids)
      can :create, DiscussionMessage, :discussion_id => discussions
      
      can [:new, :create], Event
      can [:index, :show, :add_entry, :remove_entry, :get_by_date], Event, :group_id => user.group_ids
      can [:edit, :update, :destroy], Event, :organizer => user.id
      
      events = Event.where(:group_id => user.group_ids)
      can :create, EventMessage, :event_id => events
      
      can :manage, Group, :group_id => user.group_ids
      
      can :manage, User, :id => user.id      
    elsif user.has_role? :ordinary_user
      can :manage, DirectMessage
      
      can [:new, :create], Discussion
      can [:index, :show], Discussion, :group_id => user.group_ids
      can [:edit, :update, :destroy], Discussion, :user_id => user.id
      
      discussions = Discussion.where(:group_id => user.group_ids)
      can :create, DiscussionMessage, :discussion_id => discussions
      
      can [:new, :create], Event
      can [:index, :show, :add_entry, :remove_entry, :get_by_date], Event, :group_id => user.group_ids
      can [:edit, :update, :destroy], Event, :organizer => user.id
      
      events = Event.where(:group_id => user.group_ids)
      can :create, EventMessage, :event_id => events
      
      can :show, Group, :group_id => user.group_ids
      
      can :manage, User, :id => user.id      
    end
  end
end
