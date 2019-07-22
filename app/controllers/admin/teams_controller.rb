class Admin::TeamsController < Admin::BaseController
  include Admin::TeamsHelper
  before_action :authorize_access
  before_action :set_race

  guards_permissions :team

  def index
    @teams = @race.teams
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
      redirect_to [:edit, :admin, @site, @race, @team], notice: "The team has been created."
    else
      flash.now.alert = errors_for(@team)
      render :form
    end
  end

  def update
    @team = @race.teams.find(params[:id])
    if @team.update(team_params)
      redirect_to [:edit, :admin, @site, @race, @team], notice: "The team has been updated."
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

  def team_params
    @team_params = params[:team].permit!.to_h
    @team_params["riders_attributes"] = @team_params["riders_attributes"].reduce({}) do |riders_attributes, (index, attributes)|
      if attributes["_destroy"] == "1"
        Rider.destroy(attributes["id"])
        riders_attributes
      else
        riders_attributes.merge index => attributes
      end
    end
    @team_params
  end
end
