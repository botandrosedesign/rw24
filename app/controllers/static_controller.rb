class StaticController < ContentController
  layout :theme_layout

  def dispatch
    render :action => params[:name]
  end
  
  def deliver_register
    riders = []
    
    case params[:class]
      
      when "Solo"
        qty = 1
        riders << params[:captain]
        
      when "Tandem"
        qty = 2
        riders << params[:captainT]
        riders << params[:rider_twoT]
        
      else
        qty = params[:number].to_i
        ab = params[:class].chars.to_a.last
        riders << params[:"captain#{ab}"]
        2.upto(qty) do |i|
          riders << params[:"rider_#{i}#{ab}"]
        end

    end
    
    @form = {
      :amount => 0.01,#qty * 20,
      :item_name => "Riverwest 24 Registration - #{params[:class]} Class",
      :cmd => "_xclick",
      :custom => "T:#{params[:name]}, P:#{params[:phone]}, E:#{params[:email]}. #{qty} Riders: #{riders.join(", ")}"
    }
    
    render :layout => false
    
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
