class GroupAdmin < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  attr_accessible :user_id, :group_id
  
  def self.get_group_admins(user_id)
    GroupAdmin.where(:user_id => user_id)
  end
end
