class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    # The events visible should be the ones the belongs to the users groups



    @event = Event.new
    @events = Event.where(:group_id => current_user.group_ids)
    @groups = current_user.groups


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @entries = Entry.where(:event_id => params[:id]).order("created_at DESC")
    @current_user_entry = Entry.where(:event_id => params[:id], :user_id => current_user.id).count
    @messages = EventMessage.where(:event_id => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.organizer = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  def get_by_date
    @events = Event.where(:group_id => current_user.group_ids).where('start_time BETWEEN ? AND ?', DateTime.parse(params[:date].to_s).beginning_of_day, DateTime.parse(params[:date].to_s).end_of_day)
    
    @json_events = @events.collect do |event|
      {:title => event.title, :id => event.id, :start => event.start_time, :entries => event.entries.count}
    end
    
    respond_to do |format|
      format.json { render json: @json_events }
    end
  end
  
  def add_entry
    @entry = Entry.new(:user_id => current_user.id, :event_id => params[:id])
    
    if @entry.save
      respond_to do |format|
        format.html { redirect_to event_path(params[:id]) }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to event_path(params[:id]), notice: "You've already joined this event" }
      end
    end
  end
  
  def remove_entry
    @entry = Entry.find(params[:id])
    @entry.destroy
    
    respond_to do |format|
      format.html { redirect_to event_path(params[:id]) }
      format.js
    end
  end
end
