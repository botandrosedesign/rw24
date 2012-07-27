class PointsController < BaseController
  before_filter :guess_section
  before_filter :authorize_access
  before_filter :set_race

  def index
    @points = @race.points.all :limit => 100
    @lap = Point.new_lap
    @bonus = Point.new_bonus
    @penalty = Point.new_penalty
  end

  def bonus
    @checkpoint = Bonus.find_by_race_and_key @race, params[:key]
    @bonuses = @race.points.where(:category => "Bonus", :bonus_id => @checkpoint.id).limit(100)
    @bonus = Point.new_bonus
  end

  def show
    @team = @race.teams.find_by_position params[:id]
    render "teams/show"
  end

  def new
    @point = Point.new :race => @race
    @point.attributes = params[:point]
    @point.valid?
    render :action => "form", :layout => false
  end

  def edit
    @point = Point.find(params[:id])
    @point.valid?
    render :action => "form", :layout => false
  end

  def create
    @point = Point.new :race => @race
    @point.attributes = params[:point]

    respond_to do |wants|
      if @point.save
        wants.js { render @point }
        wants.html { redirect_to point_path(@point.team.position) }
      else
        wants.js { render :text => @point.errors.full_messages.join(", "), :status => 406 }
        wants.html { render :new }
      end
    end
  end

  def update
    @point = Point.find(params[:id])

    respond_to do |wants|
      if @point.update_attributes(params[:point])
        wants.js { render @point }
        wants.html { redirect_to point_path(@point.team.position) }
      else
        wants.js { render :text => @point.errors.full_messages.join(", "), :status => 407 }
        wants.html { render :edit }
      end
    end
  end

  def destroy
    @point = Point.find(params[:id])

    respond_to do |wants|
      if @point.destroy
        wants.js { head(200) }
        wants.html { redirect_to point_path(@point.team.position) }
      else
        wants.js { head(500) }
        wants.html { redirect_to point_path(@point.team.position) }
      end
    end
  end

  private

    def authorize_access
      redirect_to admin_sites_url unless current_user.try(:has_role?, :superuser)
    end

    def set_race
      @race = Race.current
    end
end
