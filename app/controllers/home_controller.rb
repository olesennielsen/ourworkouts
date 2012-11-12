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
    
    data_array = [[1351728000000,12908846],[1351814400000,21406152],[1352073600000,18903032],[1352160000000,13389863],[1352246400000,28344598],[1352332800000,37719477],[1352419200000,33210928]]
    @timeline = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:defaultSeriesType] = "column"
      f.options[:chart][:height] = 250
      f.options[:title][:text] = "TimeLine for user " + current_user.email
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
