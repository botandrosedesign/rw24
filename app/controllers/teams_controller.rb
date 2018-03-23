class TeamsController < BaseController
  before_action :set_race
  before_action :guess_section

  def index
    @teams = @race.teams.leader_board
    respond_to do |format|
      format.html
      format.js { render @teams, :layout => false }
    end
    expires_in 1.minute, public: true if Rails.env.production?
  end

  def show
    @team = @race.teams.find_by_position! params[:position]
  end

  private

  def set_race
    @race = Race.find_by_year(params[:year]) || Race.current
  end
end
