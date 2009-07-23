class InputController < ApplicationController
  before_filter :admin_only

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

  private
    def admin_only
      redirect_to root_path unless current_user.is_a? User and current_user.admin?
    end
end
