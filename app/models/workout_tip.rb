class WorkoutTip < ActiveRecord::Base
  attr_accessible :author, :body, :tip_date, :title
  
  validates :author, :presence => true
  validates :body, :presence => true
  validates :title, :presence => true
  
  def self.get_tip
    tip = WorkoutTip.where(:tip_date => Date.today)
    
    if tip.empty?
      tip = WorkoutTip.first(:offset => rand(WorkoutTip.count))     
    end
    
    return tip
  end
end
