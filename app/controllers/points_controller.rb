class PointsController < BaseController
  before_filter :guess_section
  before_filter :authorize_access
  before_filter :set_race

  def index
    @points = @race.points.all :limit => 100
    @lap = Point.new_lap :race => @race
    @bonus = Point.new_bonus :race => @race
    @penalty = Point.new_penalty :race => @race
  end

  def new
    @point = Point.new(params[:point])
    @point.valid?
    render :action => "form", :layout => false
  end

  def edit
    @point = Point.find(params[:id])
    @point.valid?
    render :action => "form", :layout => false
  end

  def create
    @point = Point.new(params[:point])

    if @point.save
      render @point
    else
      render :text => @point.errors.full_messages.join(", "), :status => 406
    end
  end

  def update
    @point = Point.find(params[:id])

    if @point.update_attributes(params[:point])
      render @point
    else
      render :text => @point.errors.full_messages.join(", "), :status => 406
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.destroy
      head(200)
    else
      head(500)
    end
  end

  private

    def authorize_access
      redirect_to admin_sites_url unless current_user.try(:has_role?, :superuser)
    end

    def current_user
      @current_user ||= User.find(cookies[:uid]) rescue nil
    end

    def set_race
      @race = Race.current
    end
end
