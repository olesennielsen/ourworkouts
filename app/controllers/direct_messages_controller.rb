class DirectMessagesController < ApplicationController
  # GET /direct_messages
  # GET /direct_messages.json
  def index
    @direct_messages = DirectMessage.get_direct_messages(current_user)
    
    @recipients = User.reachable_users(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @direct_messages }
    end    
  end

  # GET /direct_messages/1
  # GET /direct_messages/1.json
  def show
    @direct_message = DirectMessage.find(params[:id])
    
    r_name = User.find(@direct_message.recipient_id)    
    
    @json_request = {recipient: r_name.name}
    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @json_request }
    end
  end

  # POST /direct_messages
  # POST /direct_messages.json
  def create
    @direct_message = DirectMessage.create!(params[:direct_message])
    respond_to do |format|
        #format.html { redirect_to direct_messages_path, notice: 'Direct message was successfully created.' }
        #format.json { render json: @direct_message, status: :created, location: @direct_message }
      format.js
    end
  end

  # PUT /direct_messages/1
  # PUT /direct_messages/1.json
  def update
    @direct_message = DirectMessage.find(params[:id])
    respond_to do |format|
      if @direct_message.update_attributes(params[:direct_message])
        format.html { redirect_to @direct_message, notice: 'Direct message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @direct_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /direct_messages/1
  # DELETE /direct_messages/1.json
  def destroy
    @direct_message = DirectMessage.find(params[:id])
    @direct_message.destroy

    respond_to do |format|
      format.html { redirect_to direct_messages_url }
      format.json { head :no_content }
      format.js
    end
  end
end