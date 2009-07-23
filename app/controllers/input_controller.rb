class InputController < ApplicationController
  layout nil
  
  def new
    @lap = Lap.new
  end

  # POST /teams
  def create
    @lap = Lap.new params[:lap] 
    if @lap.save
      flash[:notice] = "Lap \##{@lap.team.laps.count} logged for Team \##{@lap.team.number}"
    else
      flash[:error] = "Team \##{params[:lap][:team_number]} doesn't exist!"
    end
    redirect_to input_path
  end
end
