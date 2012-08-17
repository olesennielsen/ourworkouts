class DiscussionMessage < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  attr_accessible :body
end
