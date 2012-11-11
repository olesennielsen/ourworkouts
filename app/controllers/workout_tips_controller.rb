class WorkoutTipsController < ApplicationController
  def index
     @tips = WorkoutTip.where('tip_date <= ?', Date.today).order('tip_date DESC')
  end  
  
  def new
    @workout_tips = WorkoutTip.find(:all, :order => "tip_date DESC")
    authorize! :new, @workout_tips
  end
  
  def edit
    @workout_tip = WorkoutTip.find(params[:id])
    authorize! :edit, @workout_tip
  end
  
  def create
    @workout_tip = WorkoutTip.new(params[:workout_tip])
    @workout_tips = WorkoutTip.find(:all, :order => "tip_date DESC")
    last_tip = WorkoutTip.find(:last)
    authorize! :create, @workout_tip
    respond_to do |format|
      if @workout_tip.save
        @workout_tip.update_attributes(:tip_date => last_tip.tip_date + 1.day)
        format.html { redirect_to new_workout_tip_path, notice: 'Workout tip was successfully created' }
        format.json { render json: @workout_tip, status: :created, location: @workout_tip }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @workout_tip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @workout_tip = WorkoutTip.find(params[:id])
    authorize! :update, @workout_tip
    respond_to do |format|
      if @workout_tip.update_attributes(params[:workout_tip])
        format.html { redirect_to new_workout_tip_path, notice: 'Workout tip was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @workout_tip = WorkoutTip.find(params[:id])
    authorize! :destroy, @workout_tip
    @workout_tip.destroy
    
    respond_to do |format|
      format.html { redirect_to new_workout_tip_path, notice: 'Workout tip was successfully deleted'}
      format.js
    end      
  end
end
