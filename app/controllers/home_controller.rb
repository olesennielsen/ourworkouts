class HomeController < ApplicationController
  def index
    @tip = WorkoutTip.where(:tip_date => Date.today).first
  end
  
  def sign_up
  end
  
  def what
    @events = Event.where(:group_id => 1)
  end
  
  def who
    @groups = Group.where(:public => true)
  end
  
  def how
  end
  
  def workout_tips
    @tips = WorkoutTip.where('tip_date <= ?', Date.today).order('tip_date DESC')
  end
  
end
