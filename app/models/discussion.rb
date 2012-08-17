class Discussion < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :discussion_messages
  
  attr_accessible :title, :user_id, :group_id, :discussion_messages_attributes
  accepts_nested_attributes_for :discussion_messages, :allow_destroy => true
  
  def last_message
    return self.discussion_messages.last.body
  end
  
  def last_contributor
    return self.discussion_messages.last.user.name
  end
end
