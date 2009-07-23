class RacersController < ContentController
  def index
    @racers = Racer.all(:include => :team)
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
    @racer = Racer.new params[:racer]

    if @racer.save
      flash[:notice] = 'Racer was successfully created.'
      redirect_to racers_path
    else
      render :action => "new"
    end
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
end
