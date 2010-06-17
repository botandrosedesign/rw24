class Admin::RidersController < Admin::BaseController
  include Admin::RidersHelper
  include Admin::TeamsHelper
  before_filter :authorize_access

  guards_permissions :rider

  def index
    @riders = Rider.all :order => "name"
  end
  
  def show
    @rider = Rider.find params[:id]
  end

  def new
    @rider = Rider.new(params[:rider])
  end

  def edit
    @rider = Rider.find params[:id]
  end

  def create
    @rider = Rider.new(params[:rider])
    if @rider.save
      flash[:notice] = "The rider has been created."
      redirect_to edit_admin_rider_path(@site, @rider)
    else
      flash.now[:error] = "The rider could not be created."
      render :action => :new
    end
  end

  def update
    @rider = Rider.find params[:id]
    if @rider.update_attributes(params[:rider])
      flash[:notice] = "The rider has been updated."
      redirect_to edit_admin_rider_path(@site, @rider)
    else
      flash.now[:error] = "The rider could not be updated."
      render :action => :edit
    end
  end

  def destroy
    @rider = Rider.find params[:id]
    if @rider.destroy
      flash[:notice] = "The rider has been destroyed."
      redirect_to edit_admin_team_path(@site, @rider.team)
    else
      flash.now[:error] = "The rider could not be destroyed."
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
