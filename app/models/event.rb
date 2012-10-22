class Event < ActiveRecord::Base
  belongs_to :group
  has_many :event_messages
  has_many :entries
  has_many :users, :through => :entries  

  attr_accessor :end_hour_minute, :end_date, :start_hour_minute, :start_date

  attr_accessible :end_time, :end_hour_minute, :end_date, :milestone, :description, :start_time, :start_hour_minute, :start_date, :title, :group_id, :all_day, :organizer

  before_validation :make_start_time, :make_end_time
  
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => start_time,
      :end => end_time,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
  end

  def synthesize_time(date_string, time_string)
    if date_string.present? && time_string.present?
      date = Date.strptime(date_string, "%d-%m-%Y")
      time = DateTime.strptime(time_string, "%l:%M%P")
      puts time
      return DateTime.new(date.year, date.month, date.day, time.hour, time.minute)
    else
      return DateTime.new(date.year, date.month, date.day)
    end
  end    

  def make_end_time
    if not self.end_time.present?
    self.end_time = synthesize_time(@end_date, @end_hour_minute)
    end
  end

  def make_start_time
    if not self.start_time.present?
      self.start_time = synthesize_time(@start_date, @start_hour_minute)
    end
  end
end
