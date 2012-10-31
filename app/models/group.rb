class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :sports
  has_many :events
  has_many :discussions
  has_many :user_invitations
  has_many :group_admins
  attr_accessible :description, :name, :public
end
