class Admin::LinksController < Admin::BaseController
  default_param :link, :author_id, :only => [:create, :update], &lambda { current_user.id }

  before_filter :protect_single_link_mode
  before_filter :set_section
  before_filter :set_links,   :only => [:index]
  before_filter :set_link,    :only => [:show, :edit, :update, :destroy]
  before_filter :set_categories, :only => [:new, :edit]
  before_filter :optimistic_lock, :only => :update

  guards_permissions :link, :update => :update_all

  def index
  end

  def show
    @link.revert_to(params[:version]) if params[:version]
    render :template => "#{@section.type.tableize}/links/show", :layout => 'default'
  end

  def new
    defaults = { :comment_age => @section.comment_age, :filter => @section.content_filter }
    @link = @section.links.build(defaults.update(params[:link] || {}))
  end

  def edit
  end

  def create
    @link = @section.links.build(params[:link])
    if @link.save
      trigger_events(@link)
      flash[:notice] = t(:'adva.links.flash.create.success')
      redirect_to edit_admin_link_url(:id => @link.id, :cl => content_locale)
    else
      set_categories
      flash.now[:error] = t(:'adva.links.flash.create.failure')
      render :action => 'new'
    end
  end

  def update
    params[:link][:version].present? ? rollback : update_attributes
  end

  def update_attributes
    @link.attributes = params[:link]

    if save_with_revision? ? @link.save : @link.save_without_revision
      trigger_events(@link)
      flash[:notice] = t(:'adva.links.flash.update.success')
      redirect_to edit_admin_link_url(:cl => content_locale)
    else
      set_categories
      flash.now[:error] = t(:'adva.links.flash.update.failure')
      render :action => 'edit', :cl => content_locale
    end
  end

  def rollback
    version = params[:link][:version].to_i

    if @link.version != version and @link.revert_to(version)
      trigger_event(@link, :rolledback)
      flash[:notice] = t(:'adva.links.flash.rollback.success', :version => version)
      redirect_to edit_admin_link_url(:cl => content_locale)
    else
      flash[:error] = t(:'adva.links.flash.rollback.failure', :version => version)
      redirect_to edit_admin_link_url(:cl => content_locale)
    end
  end

  def destroy
    if @link.destroy
      trigger_events(@link)
      flash[:notice] = t(:'adva.links.flash.destroy.success')
      redirect_to admin_contents_url
    else
      set_categories
      flash.now[:error] = t(:'adva.links.flash.destroy.failure')
      render :action => 'edit'
    end
  end

  protected

    def current_resource
      @link || @section
    end

    def set_menu
      @menu = Menus::Admin::Links.new
    end

    def set_links
      @links = @section.links.filtered params[:filters]
    end

    def set_link
      @link = @section.links.find(params[:id])
    end

    def set_categories
      @categories = @section.categories.roots
    end

    def save_with_revision?
      @save_revision ||= !!params.delete(:save_revision)
    end

    # # adjusts the action from :index to :new or :edit when the current section and it doesn't have any links
    # def adjust_action
    #   if params[:action] == 'index' and @section.try(:single_link_mode)
    #     if @section.links.empty?
    #       action = 'new'
    #       params[:link] = { :title => @section.title }
    #     else
    #       action = 'edit'
    #       params[:id] = @section.links.first.id
    #     end
    #     @action_name = @_params[:action] = request.parameters['action'] = action
    #   end
    # end

    def protect_single_link_mode
      if params[:action] == 'index' and @section.try(:single_link_mode)
        redirect_to @section.links.empty? ?
          new_admin_link_url(@site, @section, :link => { :title => @section.title }) :
          edit_admin_link_url(@site, @section, @section.links.first)
      end
    end
    
    def optimistic_lock
      return unless params[:link]
      
      unless updated_at = params[:link].delete(:updated_at)
        # TODO raise something more explicit here
        raise t(:'adva.links.exception.missing_timestamp')
      end
      
      # We parse the timestamp of link too so we can get rid of those microseconds postgresql adds
      if @link.updated_at && (Time.zone.parse(updated_at) != Time.zone.parse(@link.updated_at.to_s))
        flash[:error] = t(:'adva.links.flash.optimistic_lock.failure')
        render :action => :edit
      end
    end
end

