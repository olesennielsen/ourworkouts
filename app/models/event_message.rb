class EventMessage < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  attr_accessible :body
end
