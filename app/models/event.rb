class Event < ActiveRecord::Base
  belongs_to :group
  has_many :event_messages
  has_many :entries
  has_many :users, :through => :entries  
  
  attr_accessible :end_time, :milestone, :notes, :start_time, :title
end
