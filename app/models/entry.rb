class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  attr_accessible :event_id, :user_id
  
  validates_uniqueness_of :user_id, :scope => [:event_id]
  validates :event_id, :presence => true
end
