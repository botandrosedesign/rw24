class Admin::RacesController < Admin::BaseController
  def index
    redirect_to [:admin, @site, Race.last, :teams]
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new params[:race]
    if @race.save
      expire_all_cached_pages
      redirect_to [:admin, @site, @race, :teams], :notice => "Race created!"
    else
      render :new
    end
  end

  def update
    @race = Race.find params[:id]
    @race.update_attributes params[:race]
    expire_all_cached_pages
    redirect_to [:admin, @site, @race, :teams]
  end
end
