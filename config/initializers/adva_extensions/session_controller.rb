ActiveSupport::Reloader.to_prepare do
  SessionController.class_eval do
    def create
      if authenticate_user(params[:user])
        remember_me! if params[:user][:remember_me]
        flash[:notice] = t(:'adva.session.flash.create.success')
        redirect_to return_from(:login)
      else
        if unverified_user = User.find_by(email: params[:user][:email], verified_at: nil)
          Mailer.registration(unverified_user, request.host_with_port).deliver_now
          redirect_to "/", alert: "Profile already exists but is unconfirmed. A confirmation email has been sent to #{unverified_user.email}"
        else
          @user = User.new(:email => params[:user][:email])
          @remember_me = params[:user][:remember_me]
          flash.now[:error] = t(:'adva.session.flash.create.failure')
          render :action => 'new'
        end
      end
    end
  end
end


