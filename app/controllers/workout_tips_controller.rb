class WorkoutTipsController < ApplicationController
  def new
    @workout_tip = WorkoutTip.new
  end
  
  def create
    @workout_tip = WorkoutTip.new(params[:workout_tip])
    
    last_tip = WorkoutTip.find(:last)
    
    respond_to do |format|
      if @workout_tip.save
        @workout_tip.update_attributes(:tip_date => last_tip.tip_date + 1.day)
        format.html { redirect_to new_workout_tip_path, notice: 'Workout tip was successfully created.' }
        format.json { render json: @workout_tip, status: :created, location: @workout_tip }
      else
        format.html { render action: "new" }
        format.json { render json: @workout_tip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
  
  end
  
  def destroy
  
  end
end
