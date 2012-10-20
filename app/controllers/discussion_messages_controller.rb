class DiscussionMessagesController < ApplicationController
  load_and_authorize_resource
  # POST /discussion_messages
  # POST /discussion_messages.json
  def create
    @discussion_message = DiscussionMessage.create!(params[:discussion_message])
    respond_to do |format|    
      format.html { redirect_to discussion_path(@discussion_message.discussion), notice: 'discussion_message was successfully added' }
      format.json { render json: @discussion_message, status: :created, location: @discussion_message }
      format.js
    end
  end

  # PUT /discussion_messages/1
  # PUT /discussion_messages/1.json
  def update
    @discussion_message = DiscussionMessage.find(params[:id])

    respond_to do |format|
      if @discussion_message.update_attributes(params[:discussion_message])
        format.html { redirect_to @discussion_message, notice: 'discussion_message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussion_messages/1
  # DELETE /discussion_messages/1.json
  def destroy
    @discussion_message = DiscussionMessage.find(params[:id])
    @discussion_message.destroy

    respond_to do |format|
      format.html { redirect_to discussion_path(@discussion_message.discussion), notice: 'discussion_message was successfully deleted' }
      format.js
      format.json { head :no_content }
    end
  end  
end
