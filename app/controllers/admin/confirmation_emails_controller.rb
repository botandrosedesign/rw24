class Admin::ConfirmationEmailsController < Admin::BaseController
  def edit
  end

  def update
    if @site.update(params[:site])
      redirect_to [:admin, @site, :races], notice: "CONFIRMATION EMAIL UPDATED"
    else
      render :edit
    end
  end
end

