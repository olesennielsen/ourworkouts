class HomeController < ApplicationController
  def index
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
  
end
