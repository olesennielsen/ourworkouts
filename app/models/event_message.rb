class EventMessage < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  attr_accessible :body, :event_id, :user_id
end
