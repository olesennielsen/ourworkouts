class HomeController < ApplicationController
  def index
    @tip = WorkoutTip.where(:tip_date => Date.today).first
  end
  
  def dashboard
    # events for the timeline
    groups = current_user.groups
    @milestone_events = []
    
    groups.each do |group|
      tmp_events = Event.where(:group_id => group.id).where(:milestone => true).order("start_time ASC")
      tmp_events.each do |tmp_event|
        @milestone_events.push(tmp_event)
      end
    end
    
    if Date.today + 10 > @milestone_events.first.start_time.to_date
      @milestone_events.drop(1)
    end
    
    @milestone_event = @milestone_events.first
    
    @days_to_milestone_event = @milestone_event.start_time.to_date - Date.today
    
    
    
    # rest of the page
    @tip = WorkoutTip.where(:tip_date => Date.today).first
    @direct_messages = DirectMessage.where(:recipient_id => current_user).order('created_at DESC').limit(5)
    
    @groups = current_user.groups
    @events = []
    @discussions = []
    @discussion_messages = []
    
    @groups.each do |group|
      tmp_events = Event.where(:group_id => group.id).where('start_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      tmp_events.each do |tmp_event|
        @events.push(tmp_event)
      end
      
      tmp_discussions = Discussion.where(:group_id => group.id)
      tmp_discussions.each do |tmp_discussion|
        @discussions.push(tmp_discussion)
      end      
    end
    
    @discussions.each do |discussion|
      tmp_discussion_messages = DiscussionMessage.where(:discussion_id => discussion)
      tmp_discussion_messages.each do |tmp_discussion_message|
        @discussion_messages.push(tmp_discussion_message)
      end
    end
    
    @discussion_messages = @discussion_messages.sort_by { |discussion_message| discussion_message.created_at }.reverse.first(5)
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
