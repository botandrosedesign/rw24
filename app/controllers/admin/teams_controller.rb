class Admin::TeamsController < Admin::BaseController
  include Admin::TeamsHelper
  before_filter :authorize_access
  before_filter :set_race

  guards_permissions :team

  def index
    @teams = @race.teams
  end
  
  def show
    @team = @race.teams.find(params[:id])
  end

  def new
    @team = @race.teams.build
    6.times { @team.riders << Rider.new }
  end

  def edit
    @team = @race.teams.find(params[:id])
  end

  def create
    @team = @race.teams.build(params[:team])
    if @team.save
      redirect_to [:edit, :admin, @site, @race, @team], notice: "The team has been created."
    else
      until @team.riders.length == 6
        @team.riders << Rider.new
      end
      flash.now.alert = errors_for(@team)
      render action: :new
    end
  end

  def update
    @team = @race.teams.find(params[:id])
    if @team.update(params[:team])
      redirect_to [:edit, :admin, @site, @race, @team], notice: "The team has been updated."
    else
      flash.now.alert = errors_for(@team)
      render action: :edit
    end
  end

  def destroy
    @team = @race.teams.find(params[:id])
    @team.destroy
    redirect_to [:admin, @site, @race, :teams], notice: "The team has been destroyed."
  end

  def send_confirmation_emails
    Team.send_confirmation_email_by_ids params[:team_ids]
    redirect_to [:admin, @site, @race, :teams], notice: "Confirmation emails sending!"
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find(params[:race_id])
  end

  def authorize_access
    redirect_to admin_sites_url unless @site || current_user.has_role?(:superuser)
  end
end
