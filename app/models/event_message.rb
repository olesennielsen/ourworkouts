class EventMessage < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  attr_accessible :body, :event_id, :user_id
  
  validates :body, :presence => true
  validates :event_id, :presence => true
  validates :user_id, :presence => true
end
