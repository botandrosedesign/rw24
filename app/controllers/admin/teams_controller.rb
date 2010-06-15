class Admin::TeamsController < Admin::BaseController
  include Admin::TeamsHelper
  before_filter :authorize_access

  guards_permissions :team

  def index
    @teams = Team.all
  end
  
  def show
    @team = Team.find params[:id]
  end

  def new
    @team = Team.new(params[:team])
  end

  def edit
    @team = Team.find params[:id]
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "The team has been created."
      redirect_to edit_admin_team_path(@site, @team)
    else
      flash.now[:error] = "The team could not be created."
      render :action => :new
    end
  end

  def update
    @team = Team.find params[:id]
    if @team.update_attributes(params[:team])
      flash[:notice] = "The team has been updated."
      redirect_to edit_admin_team_path(@site, @team)
    else
      flash.now[:error] = "The team could not be updated."
      render :action => :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    if @team.destroy
      flash[:notice] = "The team has been destroyed."
      redirect_to admin_teams_url(@site)
    else
      flash.now[:error] = "The team could not be destroyed."
      render :action => :edit
    end
  end

  private

    def set_menu
      @menu = Menus::Admin::Races.new
    end

    def authorize_access
      redirect_to admin_sites_url unless @site || current_user.has_role?(:superuser)
    end
end
