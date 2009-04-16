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
    NotificationMailer.deliver_sponsor(params)
    flash[:notice] = "Thanks for your interest in sponsoring Riverwest24! We'll get in contact with you within the next 24 hours."
    redirect_to "/"
  end
end
