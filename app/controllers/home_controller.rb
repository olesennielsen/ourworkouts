class HomeController < ApplicationController
  require 'open-uri'
  require 'json'
  def index
    @tip = WorkoutTip.where(:tip_date => Date.today).first
  end
  
  def dashboard
    if user_signed_in?     
      if current_user.email.include? "@ourworkouts.com"
        redirect_to edit_user_registration_path, alert: "Please change your email and add a name while you're at it"
        return
      end
    end
    
    # the timeline data is handled exclusively by application_helper
    
    data_array = current_user.event_data
    @timeline = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:type] = "column"
      f.options[:chart][:height] = 250
      f.options[:tooltip][:pointFormat] = "<span style='color:{series.color}'>Minutes of Joy</span>: <b>{point.y}</b><br/>"
      f.options[:title][:text] = current_user.email
      f.options[:rangeSelector] = { :enabled => false, :selected => 1, :inputEnabled => false }
      f.series(:name=>current_user.name, :data=> data_array )
    end 

    # rest of the page
    @tip = WorkoutTip.where(:tip_date => Date.today).first
    @direct_messages = DirectMessage.where(:recipient_id => current_user).order('created_at DESC').limit(5)
      
    @events = Event.where(:group_id => current_user.group_ids).where('start_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      
    @discussions = Discussion.where(:group_id => current_user.group_ids)
    @discussion_messages = DiscussionMessage.where(:discussion_id => @discussions)
    
    unless @discussion_messages.nil?    
      @discussion_messages = @discussion_messages.sort_by { |discussion_message| discussion_message.created_at }.reverse.first(5)
    end
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
