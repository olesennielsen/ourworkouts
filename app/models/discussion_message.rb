class DiscussionMessage < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  
  attr_accessible :body, :user_id, :discussion_id
  
  validates :body, :presence => true
  validates :user_id, :presence => true
  #validates :discussion_id, :presence => true
end
