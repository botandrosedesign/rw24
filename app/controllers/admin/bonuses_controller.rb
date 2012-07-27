class Admin::BonusesController < Admin::BaseController
  before_filter :set_race

  def new
    @bonus = Bonus.new :points => 2
  end

  def create
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
