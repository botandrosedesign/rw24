class StaticController < ContentController
  layout :theme_layout

  def dispatch
    render :action => params[:name]
  end
end
