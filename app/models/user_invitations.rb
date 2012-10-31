class UserInvitations < ActiveRecord::Base
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :group
  belongs_to :inviter, :class_name => "User", :foreign_key =>"inviter_id"
  
  attr_accessible :group_id, :user_id, :inviter_id
end

