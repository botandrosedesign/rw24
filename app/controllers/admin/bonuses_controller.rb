class Admin::BonusesController < Admin::BaseController
  before_filter :set_race

  def show
    @bonus = Bonus.find_by_race_and_id @race, params[:id]
    @bonuses = Point.where(:bonus_id => params[:id], :race_id => @race.id, :category => "Bonus").includes(:team).reorder("teams.position")
  end

  def new
    @bonus = Bonus.new :points => 2
  end

  def create
    params[:bonus][:key] = SecureRandom.hex(8)
    @race.bonuses << params[:bonus]
    @race.save
    redirect_to [:new, :admin, @site, @race, :bonus], :notice => "Bonus added! Add another?"
  end

private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find params[:race_id]
  end
end
