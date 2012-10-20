
class EventMessagesController < ApplicationController
  load_authorize_resource
  
  # POST /event_messages
  # POST /event_messages.json
  def create
    #@event_message = EventMessage.new(params[:event_message])

    respond_to do |format|
      if @event_message.save
        format.html { redirect_to @event_message, notice: 'Event message was successfully created.' }
        format.json { render json: @event_message, status: :created, location: @event_message }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @event_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_messages/1
  # PUT /event_messages/1.json
  def update
    #@event_message = EventMessage.find(params[:id])

    respond_to do |format|
      if @event_message.update_attributes(params[:event_message])
        format.html { redirect_to @event_message, notice: 'Event message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_messages/1
  # DELETE /event_messages/1.json
  def destroy
    #@event_message = EventMessage.find(params[:id])
    @event_message.destroy

    respond_to do |format|
      format.html { redirect_to event_messages_url }
      format.json { head :no_content }
    end
  end
end
