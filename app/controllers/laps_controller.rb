class LapsController < ContentController
  layout :theme_layout

  before_filter :get_team

  def index
    @laps = @team.laps
  end

  def new
    @lap = @team.laps.build :created_at => Time.parse("2009-07-25 17:00")
  end

  def edit
    @lap = @team.laps.find params[:id]
  end

  def create
    @lap = @team.laps.build params[:lap]

    if @lap.save
      flash[:notice] = 'Lap was successfully created.'
      redirect_to [@team, :laps]
    else
      render :action => "new"
    end
  end

  def update
    @lap = @team.laps.find params[:id]

    if @lap.update_attributes params[:lap]
      flash[:notice] = 'Lap was successfully updated.'
      redirect_to [@team, :laps]
    end
  end

  def destroy
    @lap = @team.laps.find params[:id]
    @lap.destroy

    redirect_to [@team, :laps]
  end

  private
    def get_team
      @team = Team.find params[:team_id]
    end
end
