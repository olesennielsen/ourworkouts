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

  def make_end_time
    if @end_date.present? && @end_hour_minute.present?
      @end_date = @end_date.to_date
      @end_hour_minute = Time.parse(@end_hour_minute)
      self.end_time = DateTime.new(@end_date.year, @end_date.month, @end_date.day, @end_hour_minute.hour, @end_hour_minute.min)
    end
  end

  def make_start_time
    if @start_date.present? && @start_hour_minute.present?
      @start_date = @start_date.to_date
      @start_hour_minute = Time.parse(@start_hour_minute)
      self.start_time = DateTime.new(@start_date.year, @start_date.month, @start_date.day, @start_hour_minute.hour, @start_hour_minute.min)
    end
  end
end
