class Event < ActiveRecord::Base
  belongs_to :group
  has_many :event_messages
  has_many :entries
  has_many :users, :through => :entries  
  
  attr_accessible :end_time, :milestone, :description, :start_time, :title, :group_id, :all_day

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => start_time.rfc822,
      :end => end_time.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
