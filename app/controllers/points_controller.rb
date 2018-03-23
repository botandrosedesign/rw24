class PointsController < BaseController
  before_action :guess_section
  before_action :set_race
  before_action :authorize_access

  def index
    @points = @race.points.limit(100)
    @lap = Point.new_lap
    @bonus = Point.new_bonus
    @penalty = Point.new_penalty
  end

  def bonuses
    render layout: false
  end

  def bonus
    @checkpoint = Bonus.find_by_race_and_key(@race, params[:key])
    @bonuses = @race.points.where(category: "Bonus", bonus_id: @checkpoint.id).limit(100)
    @bonus = Point.new_bonus
  end

  def show
    @team = @race.teams.find_by_position(params[:id])
    render "teams/show"
  end

  def new
    @point = Point.new :race => @race
    @point.attributes = params[:point]
    @point.validate
    render action: "form", layout: false
  end

  def edit
    @point = Point.find(params[:id])
    @point.validate
    render action: "form", layout: false
  end

  def create
    @point = Point.new :race => @race
    @point.attributes = params[:point]

    respond_to do |wants|
      if @point.save
        wants.js { render @point }
        wants.html { redirect_to point_path(@point.team.position) }
      else
        wants.js { render text: @point.errors.full_messages.join(", "), status: 406 }
        wants.html { render :new }
      end
    end
  end

  def split
    @point = Point.find(params[:id])
    @point.split_behind!
    redirect_to leader_board_path(year: @race.year, position: @point.team.position), notice: "Lap split into two laps"
  end

  def update
    @point = Point.find(params[:id])

    respond_to do |wants|
      if @point.update(params[:point])
        wants.js { render @point }
        wants.html { redirect_to point_path(@point.team.position) }
      else
        wants.js { render text: @point.errors.full_messages.join(", "), status: 407 }
        wants.html { render :edit }
      end
    end
  end

  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |wants|
      wants.js { head(200) }
      wants.html { redirect_to point_path(@point.team.position) }
    end
  end

  def assign_all_bonuses_bonuses
    @race.assign_all_bonuses_bonuses
  rescue AllBonusesException => error
    cookies[:flash_error] = error.message
  ensure
    redirect_to :points
  end

  private

  def authorize_access
    return true if current_user.try(:has_role?, :superuser)
    return true if Bonus.find_by_race_and_key(@race, params[:key])
    redirect_to admin_sites_url
  end

  def set_race
    @race = Race.current
  end
end

