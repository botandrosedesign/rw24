# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable


  helper :all # include all helpers, all the time
  helper_method :current_user, :start_time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
    def guess_section
      permalink = request.request_uri.split("/").second
      @section = Section.find_by_permalink permalink
      @section ||= Section.first
    end

    def current_user
      @current_user ||= User.find(cookies[:uid]) rescue nil
    end

    def start_time
      @start_time ||= Race.last.start_time
    end
end
