class SportsController < ApplicationController

  def new
    @sports = Sport.find(:all, :order => "name")
    authorize! :new, @sports
  end

  def create
    @sport = Sport.new(params[:sport])
    @sports = Sport.find(:all, :order => "name")
    authorize! :create, @sport
    respond_to do |format|
      if @sport.save
        format.html { redirect_to new_sport_path, notice: 'Sport was successfully created' }
        format.json { render json: @sport, status: :created, location: @sport }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @sport.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @sport = Sport.find(params[:id])
    authorize! :destroy, @sport
    @sport.destroy
    
    respond_to do |format|
      format.html { redirect_to new_sport_path, notice: 'Sport was successfully deleted'}
      format.js
    end
  end
end
