class Admin::RacesController < Admin::BaseController
  def index
    redirect_to [:admin, @site, Race.last, :teams]
  end
end
