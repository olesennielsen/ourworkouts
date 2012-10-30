class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def update
    @admin_groups = Group.joins("INNER JOIN group_admins ON group_admins.group_id = groups.id AND user_id = #{current_user.id}")
    @groups = current_user.groups
    @invitations = current_user.invitees
    @invitations_string = "You have no pending group invitations" 
    super
  end
    
  def edit

    @admin_groups = Group.joins("INNER JOIN group_admins ON group_admins.group_id = groups.id AND user_id = #{current_user.id}")
    @groups = current_user.groups
    @invitations = current_user.invitees
    @invitations_string = "You have no pending group invitations"
    super
  end

  def add_user
    current_user.groups << Group.find(params[:id])
    UserInvitations.destroy_all(:user_id => current_user.id, :group_id => params[:id])
    redirect_to root_url, :notice => "You have joined a group"
  end
end 
