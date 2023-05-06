class Admin::RacesController < Admin::BaseController
  def index
    @races = Race.order(year: :desc)
    if @races.none?
      redirect_to action: :new
    end
  end

  def new
    @race = Race.new
    render :form
  end

  def edit
    race
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
    if race.update(params[:race])
      @site.touch # expire all cached pages
      redirect_to [:admin, @race, :teams], notice: "Race updated!"
    else
      render :form
    end
  end

  private

  def race
    @race ||= Race.find_by_id(params[:id])
  end

  def set_menu
    @menu = Menus::Admin::Races.new
  end
end
