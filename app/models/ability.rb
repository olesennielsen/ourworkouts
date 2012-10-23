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
      can [:index, :show], Discussion, :group => { :id => user.group_ids }
      can [:edit, :update, :destroy], Discussion, :user_id => user.id
      
      can :create, DiscussionMessage, :discussion => {:group => { :id => user.group_ids }}
      
      can [:new, :create], Event      
      can :show, Event, :group => { :id => user.group_ids }
      can [:edit, :update, :destroy], Event, :organizer => user.id
      
      can [:add_entry, :remove_entry], Entry, :event => {:group => { :id => user.group_ids }}
      
      can :create, EventMessage, :event => {:group => { :id => user.group_ids }}
      
      group_admins = GroupAdmin.where(:user_id => user.id)
      group_admins.each do |group_admin|
        can :manage, Group, :id => group_admin.group.id
      end
      
      can :show, Group, :id => user.group_ids
      
      can :manage, User, :id => user.id
          
    elsif user.has_role? :ordinary_user
      can :manage, DirectMessage
      
      can [:new, :create], Discussion
      can [:index, :show], Discussion, :group => { :id => user.group_ids }
      can [:edit, :update, :destroy], Discussion, :user_id => user.id
      
      can :create, DiscussionMessage, :discussion => {:group => { :id => user.group_ids }}
      
      can [:new, :create], Event      
      can :show, Event, :group => { :id => user.group_ids }
      can [:edit, :update, :destroy], Event, :organizer => user.id
      
      can [:add_entry, :remove_entry], Entry, :event => {:group => { :id => user.group_ids }}
      
      can :create, EventMessage, :event => {:group => { :id => user.group_ids }}
      
      can :show, Group, :id => user.group_ids
      
      can :manage, User, :id => user.id
    end
  end
end
