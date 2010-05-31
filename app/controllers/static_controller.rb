class StaticController < ApplicationController
  def dispatch
    view_template_path = "/static/"+params[:path].join("/")
    begin
      render view_template_path, :layout => true
    rescue ActionView::MissingTemplate
      begin
        render view_template_path+"/index", :layout => true
      rescue ActionView::MissingTemplate
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
