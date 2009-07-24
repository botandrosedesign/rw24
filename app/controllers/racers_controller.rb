class RacersController < ContentController
  before_filter :admin_only

  layout :theme_layout, :only => :new

  def index
    @racers = Racer.all :include => :team, :order => "teams.number DESC"
  end

  # GET /racers/1
  def show
    @racer = Racer.find params[:id]
  end

  # GET /racers/new
  def new
    @racer = Racer.new
  end

  # GET /racers/1/edit
  def edit
    @racer = Racer.find params[:id]
  end

  # POST /racers
  def create
    team_params = {
      :name => params[:name],
      :number => Team.maximum(:number) + 1,
      :team_type => params[:class]
    }
    @team = Team.new team_params

    case @team.team_type
      when "Solo" then
        Racer.create({
          :name => params[:captain],
          :team => @team,
          :payment_received_on => Date.today,
          :payment_type => "cash",
          :email => params[:email],
          :phone => params[:phone],
          :confirmed_on => Date.today
        })

      when "Tandem" then
        Racer.create({
          :name => params[:captainT],
          :team => @team,
          :payment_received_on => Date.today,
          :payment_type => "cash",
          :email => params[:email],
          :phone => params[:phone],
          :confirmed_on => Date.today
        })
        Racer.create({
          :name => params[:rider_twoT],
          :team => @team,
          :payment_received_on => Date.today,
          :payment_type => "cash",
          :confirmed_on => Date.today
        })

      when "Team A" then
        Racer.create({
          :name => params[:captainA],
          :team => @team,
          :payment_received_on => Date.today,
          :payment_type => "cash",
          :email => params[:email],
          :phone => params[:phone],
          :confirmed_on => Date.today
        })

        2.upto(6) do |i|
          next if params[:"rider_#{i}A"].blank?
          Racer.create({
            :name => params[:"rider_#{i}A"],
            :team => @team,
            :payment_received_on => Date.today,
            :payment_type => "cash",
            :confirmed_on => Date.today
          })
        end

      when "Team B" then
        Racer.create({
          :name => params[:captainB],
          :team => @team,
          :payment_received_on => Date.today,
          :payment_type => "cash",
          :email => params[:email],
          :phone => params[:phone],
          :confirmed_on => Date.today
        })

        2.upto(6) do |i|
          next if params[:"rider_#{i}B"].blank?
          Racer.create({
            :name => params[:"rider_#{i}B"],
            :team => @team,
            :payment_received_on => Date.today,
            :payment_type => "cash",
            :confirmed_on => Date.today
          })
        end
    end

    redirect_to racers_path
  end

  # PUT /racers/1
  def update
    @racer = Racer.find params[:id]

    if @racer.update_attributes params[:racer]
      flash[:notice] = 'Racer was successfully updated.'
      redirect_to racers_path 
    end
  end

  # DELETE /racers/1
  def destroy
    @racer = Racer.find params[:id]
    @racer.destroy

    redirect_to racers_path 
  end

  private
    def admin_only
      redirect_to root_path unless current_user.is_a? User and current_user.admin?
    end
end
