class Admin::CategoriesController < Admin::BaseController
  before_action :set_race

  def new
    @category = TeamCategory.new
    render :form
  end

  def create
    @category = TeamCategory.new(category_params)
    if @category.save
      @race.category_ids = @race.category_ids + [@category.id]
      @race.save!
      redirect_to [:edit, :admin, @race], notice: "Category added!"
    else
      render :form
    end
  end

  def edit
    @category = TeamCategory.find(params[:id])
    render :form
  end

  def update
    category = TeamCategory.find(params[:id])
    @category = @race.update_category(category, category_params)
    if @category.errors.none?
      redirect_to [:edit, :admin, @race], notice: "Category updated!"
    else
      render :form
    end
  end

  def destroy
    @race.category_ids = @race.category_ids - [params[:id].to_i]
    @race.save!
    redirect_to [:edit, :admin, @race], notice: "Category removed!"
  end

  private

  def set_race
    @race = Race.find(params[:race_id])
  end

  def set_menu
    @menu = Menus::Admin::Teams.new
  end

  def category_params
    params.require(:category).permit(:name, :initial, :min, :max)
  end
end
