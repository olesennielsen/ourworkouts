class Event < ActiveRecord::Base
  belongs_to :group
  has_many :event_messages, :dependent => :destroy
  has_many :entries, :dependent => :destroy
  has_many :users, :through => :entries  

  attr_accessor :end_hour_minute, :end_date, :start_hour_minute, :start_date

  attr_accessible :end_time, :end_hour_minute, :end_date, :milestone, :description, :start_time, :start_hour_minute, :start_date, :title, :group_id, :all_day, :organizer, :sport_id

  before_validation :make_start_time, :make_end_time
  
  validates :title, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :organizer, :presence => true
  validates :group_id, :presence => true
  validate :ends_at_later_than_starts_at
  
  def ends_at_later_than_starts_at
    if self.end_time < self.start_time 
      errors.add(:ends_at_later_than_starts_at, "You specify a start time later than end time")
    end
  end
  
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => start_time,
      :end => end_time,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id),
      :sport_link => Sport.find(self.sport_id).link
    }
  end

  def synthesize_time(date_string, time_string)
    if date_string.present? && time_string.present?
      date = Date.strptime(date_string, "%d-%m-%Y")
      time = DateTime.strptime(time_string, "%l:%M%P")
      puts time
      return DateTime.new(date.year, date.month, date.day, time.hour, time.minute)
    else
      date = Date.strptime(date_string, "%d-%m-%Y")
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
  
  def start_date_unix
    self.start_time.to_date.to_time.to_i * 1000
  end

  def duration
    (self.end_time - self.start_time) / 60
  end
  
  def number_of_entries
    return Entry.where(:event_id => self.id).count
  end
  
  def entered_users
    @users = []
    entries = self.entries
    entries.each do |entry|
      @users.push(entry.user)
    end
    return @users
  end
  
  def self.contain_goal_event(events)
    events.each do |event|
      if event.milestone
        return true
      end
    end
    return false    
  end
end
