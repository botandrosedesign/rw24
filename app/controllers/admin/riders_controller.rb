class Admin::RidersController < Admin::BaseController
  include Admin::RidersHelper
  include Admin::TeamsHelper
  before_action :authorize_access

  before_action :set_race, :set_team

  guards_permissions :rider

  def new
    @rider = @team.riders.build(params[:rider])
    render :form
  end

  def create
    @rider = @team.riders.build(params[:rider])
    if @rider.save
      redirect_to [:edit, :admin, @site, @race, @team], notice: "The rider has been created."
    else
      flash.now.alert = errors_for(@rider)
      render :form
    end
  end

  def destroy
    @rider = @team.riders.find(params[:id])
    @rider.destroy
    redirect_to [:edit, :admin, @site, @race, @team], notice: "The rider has been destroyed."
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find(params[:race_id])
  end

  def set_team
    @team = @race.teams.find(params[:team_id])
  end

  def authorize_access
    redirect_to admin_sites_url unless @site || current_user.has_role?(:superuser)
  end
end
