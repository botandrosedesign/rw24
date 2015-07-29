class Admin::RacesController < Admin::BaseController
  def index
    if @race = Race.last
      redirect_to [:admin, @site, @race, :teams]
    else
      redirect_to [:new, :admin, @site, :race]
    end
  end

  def new
    @race = Race.new
  end

  def edit
    @race = Race.find params[:id]
  end

  def create
    @race = Race.new params[:race]
    if @race.save
      @site.touch # expire all cached pages
      redirect_to [:admin, @site, @race, :teams], :notice => "Race created!"
    else
      render :new
    end
  end

  def update
    @race = Race.find params[:id]
    @race.update_attributes params[:race]
    @site.touch # expire all cached pages
    redirect_to [:admin, @site, @race, :teams]
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end
end
