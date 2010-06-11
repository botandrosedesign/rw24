class RegistrationsController < BaseController
  before_filter :guess_section

  def show
    @registration = Registration.new
    @registration.team = Team.new
    6.times { @registration.team.riders << Rider.new }
  end

  def create
    @registration = Registration.new params[:registration]
    if @registration.save
      render :layout => false
    else
      render :show
    end
  end

  def payment
    @registration = Registration.find params[:custom]
    @registration.update_attribute :paid, true
  end
end
