class PointsController < BaseController
  before_filter :guess_section

  def index
    @points = Point.all
    @lap = Point.new_lap
    @other = Point.new_other

    respond_to do |format|
      format.html
      format.xml  { render :xml => @points }
    end
  end

  def new
    @point = Point.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @point }
    end
  end

  def edit
    @point = Point.find(params[:id])
  end

  def create
    @point = Point.new(params[:point])

    respond_to do |format|
      if @point.save
        flash[:notice] = 'Point was successfully created.'
        format.html { redirect_to points_path }
        format.xml  { render :xml => @point, :status => :created, :location => @point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        flash[:notice] = 'Point was successfully updated.'
        format.html { redirect_to points_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_path }
      format.xml  { head :ok }
    end
  end
end
