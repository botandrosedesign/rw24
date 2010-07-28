class PointsController < BaseController
  before_filter :guess_section

  def index
    @points = Point.all
    @lap = Point.new_lap
    @bonus = Point.new_bonus
    @penalty = Point.new_penalty

    respond_to do |format|
      format.html
      format.xml  { render :xml => @points }
    end
  end

  def new
    @teams = Team.all
    @point = Point.new(params[:point])
    render :action => "form", :layout => false
  end

  def edit
    @teams = Team.all
    @point = Point.find(params[:id])
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
end
