class DiscussionsController < ApplicationController
  load_and_authorize_resource
  
  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.where(:group_id => current_user.group_ids)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discussions }
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    #@discussion = Discussion.find(params[:id])
    @initial_message = @discussion.discussion_messages.first
    @messages = @discussion.discussion_messages.drop(1)    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @discussion }
    end
  end

  # GET /discussions/new
  # GET /discussions/new.json
  def new
    #@discussion = Discussion.new
    @discussion.discussion_messages.build 
    @groups = current_user.groups
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @discussion }
    end
  end

  # GET /discussions/1/edit
  def edit
    #@discussion = Discussion.find(params[:id])
    @groups = current_user.groups
  end

  # POST /discussions
  # POST /discussions.json
  def create
    #@discussion = Discussion.new(params[:discussion]) 
    @groups = current_user.groups

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render json: @discussion, status: :created, location: @discussion }
      else
        format.html { render action: "new" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discussions/1
  # PUT /discussions/1.json
  def update
    #@discussion = Discussion.find(params[:id])
    @groups = current_user.groups
    respond_to do |format|
      if @discussion.update_attributes(params[:discussion])
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    #@discussion = Discussion.find(params[:id])
    @discussion.destroy

    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was removed' }
      format.json { head :no_content }
    end
  end
end
