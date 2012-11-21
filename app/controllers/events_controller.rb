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
    
    authorize! :show, @event
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    authorize! :new, @event
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    authorize! :edit, @event
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.organizer = current_user.id
   
    authorize! :create, @event
    respond_to do |format|
      if @event.save
        Entry.create!(:event_id => @event.id, :user_id => current_user.id)
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
    authorize! :update, @event
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
    authorize! :destroy, @event
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
    authorize! :add_entry, @entry
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
    
    if @entry.user == User.find_organizer(@entry.event.organizer)
      if @entry.event.number_of_entries == 1 # only organizer that is entried
        @entry.event.destroy
        redirect_to root_path, notice: 'Event was deleted because you as the organizer was the only one who had joined'
        return
      else
        redirect_to edit_organizer_path(:event_id => @entry.event.id)
        return
      end      
    end
    
    authorize! :remove_entry, @entry
    @entry.destroy
    
    respond_to do |format|
      format.html { redirect_to event_path(params[:id]) }
      format.js
    end
  end
  
  def edit_organizer
    @event = Event.find(params[:event_id])    
    @entries = @event.entered_users
    @entries.delete_if { |entry| entry.id == @event.organizer }
  end
  
  def update_organizer
    @event = Event.find(params[:event_id])    
    
    @entry = Entry.where(:user_id => @event.organizer, :event_id => @event.id).first
     
    respond_to do |format|
      if  @event.update_attributes(:organizer => params[:event][:organizer])
        @entry.destroy
        format.html { redirect_to root_path, notice: 'Organizer successfully changed' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_organizer_path(:event_id => @event), notice: "I'm sorry something went wrong. Please try again" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
