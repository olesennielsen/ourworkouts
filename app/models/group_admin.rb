class GroupAdmin < ActiveRecord::Base
  has_many :groups
  has_many :users

  attr_accessible :user_id, :group_id
  
  validates :user_id, :presence => true
  validates :group_id, :presence => true
  
  def self.get_group_admins(user_id)
    GroupAdmin.where(:user_id => user_id)
  end
  
  def self.get_by_group(group_id)
    GroupAdmin.where(:group_id => group_id)
  end
  
  def user
    User.find(self.user_id)
  end
end
