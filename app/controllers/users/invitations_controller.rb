class Users::InvitationsController < Devise::InvitationsController

  def new
    @groups = current_user.groups
    super
  end

  def create
    @groups = current_user.groups
    new_user_group_id = resource_params["groups"]
    new_user_group = Group.find_by_id(new_user_group_id)
    new_user_email = resource_params["email"]
    resource_params = { "email" => new_user_email }
    
    new_user = User.find_by_email(new_user_email)
    if new_user.nil?
      self.resource = resource_class.invite!(resource_params, current_inviter)
    
      if resource.errors.empty?
        user = User.find_by_email(new_user_email)
        user.groups << new_user_group
        set_flash_message :notice, :send_instructions, :email => self.resource.email
        respond_with resource, :location => after_invite_path_for(resource)
      else
        respond_with_navigational(resource) { render :new }
      end
    else
      if UserInvitations.where(:user_id => new_user.id, :group_id => new_user_group_id).exists?
        redirect_to root_url, :notice => "The user is already invited to this group"
      else if new_user.groups.include?(new_user_group)
             redirect_to root_url, :notice => "The user is already a member of this group"
           else
             UserInvitations.create(:user_id => new_user.id, :group_id => new_user_group_id, :inviter_id => current_user.id)
             redirect_to root_url, :notice => "You invitation has been sent"
           end
      end
    end
  end
end
