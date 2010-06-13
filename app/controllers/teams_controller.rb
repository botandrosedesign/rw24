class TeamsController < BaseController
  before_filter :guess_section

  def show
    @team = Team.new
    6.times { @team.riders << Rider.new }
  end

  def create
    @team = Team.new params[:team]
    if @team.save
      render :layout => false
    else
      until @team.riders.length == 6
        @team.riders << Rider.new
      end
      render :show
    end
  end

  def payment
    @team = Team.find params[:custom]
    @team.riders.each do |rider|
      rider.update_attributes :paid => true, :payment_type => "PayPal #{params[:txn_id]}"
    end
  end
end
