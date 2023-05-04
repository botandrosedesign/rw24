class Admin::RacesController < Admin::BaseController
  def index
    if @race = Race.last
      redirect_to [:admin, @race, :teams]
    else
      redirect_to [:new, :admin, :race]
    end
  end

  def new
    @race = Race.new
    render :form
  end

  def edit
    @race = Race.find(params[:id])
    render :form
  end

  def create
    @race = Race.new(params[:race].merge(category_ids: Race.last&.category_ids))
    if @race.save
      @site.touch # expire all cached pages
      redirect_to [:admin, @race, :teams], notice: "Race created!"
    else
      render :form
    end
  end

  def update
    @race = Race.find(params[:id])
    if @race.update(params[:race])
      @site.touch # expire all cached pages
      redirect_to [:admin, @race, :teams], notice: "Race updated!"
    else
      render :form
    end
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end
end
