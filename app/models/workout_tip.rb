class WorkoutTip < ActiveRecord::Base
  attr_accessible :author, :body, :tip_date, :title
  
  validates :author, :presence => true
  validates :body, :presence => true
  validates :title, :presence => true
end
