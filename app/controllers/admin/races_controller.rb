class Admin::RacesController < Admin::BaseController
  def index
    redirect_to [:admin, @site, Race.last, :teams]
  end

  def update
    @race = Race.find params[:id]
    @race.update_attributes params[:race]
    redirect_to [:admin, @site, @race, :teams]
  end
end
