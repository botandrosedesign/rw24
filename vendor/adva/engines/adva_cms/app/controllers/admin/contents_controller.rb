class Admin::ContentsController < Admin::BaseController
  default_param :content, :author_id, :only => [:create, :update], &lambda { current_user.id }

  before_filter :protect_single_content_mode
  before_filter :set_section
  before_filter :set_contents,   :only => [:index]
  before_filter :set_content,    :only => [:show, :edit, :update, :destroy]
  before_filter :set_categories, :only => [:new, :edit]
  before_filter :optimistic_lock, :only => :update

  guards_permissions :content, :update => :update_all

  def index
  end

  def update_all
    # FIXME we currently use :update_all to update the position for a single object
    # instead we should either use :update_all to batch update all objects on this
    # resource or use :update. applies to contents, sections, categories etc.
    logger.info @section.contents.update(params[:contents].keys, params[:contents].values)
    expire_cached_pages_by_reference(@section) # TODO should be in the sweeper
    render :text => 'OK'
  end
  
  protected 

    def current_resource
      @content || @section
    end

    def set_menu
      @menu = Menus::Admin::Contents.new
    end

    def set_contents
      @contents = @section.contents #.filtered params[:filters]
    end

    def set_content
      @content = @section.contents.find(params[:id])
    end

    def set_categories
      @categories = @section.categories.roots
    end

    def protect_single_content_mode
      if params[:action] == 'index' and @section.try(:single_article_mode)
        redirect_to @section.contents.empty? ?
          new_admin_article_url(@site, @section, :content => { :title => @section.title }) :
          edit_admin_article_url(@site, @section, @section.articles.first)
      end
    end
end

