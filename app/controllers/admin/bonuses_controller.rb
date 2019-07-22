class Admin::BonusesController < Admin::BaseController
  before_action :set_race

  def reposition
    new_bonuses = params[:ids].map do |json|
      bonus = JSON.parse(json).to_hash
      bonus.delete("id")
      bonus
    end
    @race.update! bonuses: new_bonuses
    head :no_content
  end

  def show
    @bonus = Bonus.find_by_race_and_id(@race, params[:id])
    @bonuses = Point.bonuses.where(bonus_id: params[:id], race_id: @race.id).includes(:team).reorder("teams.position")
  end

  def new
    @bonus = Bonus.new(points: 2)
    render :form
  end

  def edit
    @bonus = Bonus.find_by_race_and_id(@race, params[:id])
    render :form
  end

  def create
    if params[:id].present?
      update
    else
      params[:bonus][:key] = SecureRandom.hex(8)
      @race.bonuses << params[:bonus]
      @race.save
      redirect_to [:new, :admin, @site, @race, :bonus], notice: "Bonus added! Add another?"
    end
  end

  def update
    @race.bonuses[params[:id].to_i][:name] = params[:bonus][:name]
    @race.bonuses[params[:id].to_i][:points] = params[:bonus][:points]
    @race.save
    redirect_to [:edit, :admin, @site, @race], notice: "Bonus updated!"
  end

  def delete_all
    @race.bonuses = []
    @race.save
    redirect_to [:edit, :admin, @site, @race], notice: "All Bonuses deleted!"
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find(params[:race_id])
  end
end
