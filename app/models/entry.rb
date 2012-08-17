class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  attr_accessible :comment, :organizer, :event, :user
end
