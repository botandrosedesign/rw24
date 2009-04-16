class StaticController < ContentController
  layout :theme_layout

  def dispatch
    render :action => params[:name]
  end
  
  def deliver_register
    exit
  end

  def deliver_volunteer
    NotificationMailer.deliver_volunteer(params)
    flash[:notice] = "Thanks for signing up to volunteer!"
    redirect_to "/"
  end

  def deliver_sponsor
    exit
  end
end
