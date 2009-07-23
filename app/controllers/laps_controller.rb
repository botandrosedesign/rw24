class LapsController < ApplicationController
  layout nil
  
  def index
    redirect_to :action => :new
  end

  def new
    @lap = Lap.new
  end

  # POST /teams
  def create
    @lap = Lap.new(params[:lap])

    if @lap.save
      flash[:notice] = 'Lap successfully created.'
      redirect_to laps_path
    else
      render :action => "new"
    end
  end
end
