class Discussion < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :discussion_messages
  
  attr_accessible :title
end
