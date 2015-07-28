class ApplicationController < ActionController::Base
  # include ExceptionNotification::Notifiable

  helper :all # include all helpers, all the time
  helper_method :current_user, :start_time, :current_race

  protect_from_forgery with: :exception

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  def guess_section
    permalink = request.fullpath.split("/").second
    @section = Section.find_by_permalink permalink
    @section ||= Section.first
  end

  def current_user
    @current_user ||= User.find(cookies[:uid]) rescue nil
  end

  def current_race
    @current_race ||= Race.current
  end

  def start_time
    @start_time ||= current_race.start_time
  end

  def stale? *args
    if Rails.env.development?
      true
    else
      super
    end
  end
end
