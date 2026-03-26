class Admin::BonusesController < Admin::BaseController
  before_action :set_race

  def sortable
    params[:bonuses].each_with_index do |json, index|
      attrs = JSON.parse(json)
      @race.bonuses.find(attrs["id"]).update_column(:position, index + 1)
    end
    render json: true
  end

  def show
    @bonus = @race.bonuses.find(params[:id])
    @bonuses = Point.bonuses.where(bonus_id: @bonus.id, race_id: @race.id).includes(:team).reorder("teams.position")
  end

  def new
    @bonus = Bonus.new(points: 2)
    render :form
  end

  def edit
    @bonus = @race.bonuses.find(params[:id])
    render :form
  end

  def create
    if params[:id].present?
      update
    else
      @race.bonuses.create!(
        name: params[:bonus][:name],
        points: params[:bonus][:points],
        key: SecureRandom.hex(8),
      )
      redirect_to [:new, :admin, @race, :bonus], notice: "Bonus added! Add another?"
    end
  end

  def update
    bonus = @race.bonuses.find(params[:id])
    bonus.update!(
      name: params[:bonus][:name],
      points: params[:bonus][:points],
    )
    @race.points.bonuses.where(bonus_id: bonus.id).update_all(qty: bonus.points)
    redirect_to [:edit, :admin, @race], notice: "Bonus updated!"
  end

  def delete_all
    @race.bonuses.destroy_all
    redirect_to [:edit, :admin, @race], notice: "All Bonuses deleted!"
  end

  private

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def set_race
    @race = Race.find(params[:race_id])
  end
end
