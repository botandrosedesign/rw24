class Admin::RidersController < Admin::BaseController
  include Admin::RidersHelper
  include Admin::TeamsHelper
  before_filter :authorize_access

  before_filter :set_race, :set_team

  guards_permissions :rider

  def index
    @riders = @team.riders.all :order => "name"
  end
  
  def show
    @rider = @team.riders.find params[:id]
  end

  def new
    @rider = @team.riders.build(params[:rider])
  end

  def edit
    @rider = @team.riders.find params[:id]
  end

  def create
    @rider = @team.riders.build(params[:rider])
    if @rider.save
      flash[:notice] = "The rider has been created."
      redirect_to [:edit, :admin, @site, @race, @team, @rider]
    else
      flash.now[:error] = "The rider could not be created."
      render :action => :new
    end
  end

  def update
    @rider = @team.riders.find params[:id]
    if @rider.update_attributes(params[:rider])
      flash[:notice] = "The rider has been updated."
      redirect_to [:edit, :admin, @site, @race, @team, @rider]
    else
      flash.now[:error] = "The rider could not be updated."
      render :action => :edit
    end
  end

  def destroy
    @rider = @team.riders.find params[:id]
    if @rider.destroy
      flash[:notice] = "The rider has been destroyed."
      redirect_to [:edit, :admin, @site, @race, @team]
    else
      flash.now[:error] = "The rider could not be destroyed."
      render :action => :edit
    end
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find params[:race_id]
  end

  def set_team
    @team = @race.teams.find params[:team_id]
  end

  def authorize_access
    redirect_to admin_sites_url unless @site || current_user.has_role?(:superuser)
  end
end
