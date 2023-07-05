class Admin::TeamsController < Admin::BaseController
  before_action :authorize_access
  before_action :set_race

  def index
    @teams = @race.teams.includes(:category, :riders)
  end

  def new
    @team = @race.teams.build
    render :form
  end

  def edit
    @team = @race.teams.find(params[:id])
    render :form
  end

  def create
    @team = @race.teams.build(team_params)
    if @team.save
      redirect_to [:edit, :admin, @race, @team], notice: "The team has been created."
    else
      flash.now.alert = errors_for(@team)
      render :form
    end
  # teams.position uniqueness constraint can fail at db level, so just try again
  rescue ActiveRecord::StatementInvalid
    retry
  end

  def update
    @team = @race.teams.find(params[:id])
    if @team.update(team_params)
      redirect_to [:edit, :admin, @race, @team], notice: "The team has been updated."
    else
      flash.now.alert = errors_for(@team)
      render :form
    end
  end

  def destroy
    @team = @race.teams.find(params[:id])
    # prevent positions from being updated
    # TODO: replace acts_as_list with autopopulating position column and call it a day?
    Team.acts_as_list_no_update do
      @team.destroy
    end
    redirect_to [:admin, @race, :teams], notice: "The team has been destroyed."
  end

  def send_confirmation_emails
    Team.send_confirmation_email_by_ids params[:team_ids]
    redirect_to [:admin, @race, :teams], notice: "Confirmation emails sending!"
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find(params[:race_id])
  end

  def authorize_access
    redirect_to admin_sites_url unless @site || current_user.admin?
  end

  def team_params
    params[:team].permit!.to_h
  end
end
