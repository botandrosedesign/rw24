ActiveSupport::Reloader.to_prepare do
  Admin::UsersController.class_eval do
    skip_before_action :set_users, only: :index

    def index
      @users = User.all
      @user_teams = UserTeams.new
    end

    def resend_confirmation
      if user = User.find_by(id: params[:user_id], verified_at: nil)
        Mailer.registration(user, request.host_with_port).deliver_now
        respond_to do |wants|
          wants.js { render json: nil, status: 204 }
          wants.html { redirect_to({ action: :index }, notice: "Confirmation email resent to #{user.email}") }
        end
      else
        respond_to do |wants|
          wants.js { render json: nil, status: 406 }
          wants.html { redirect_to({ action: :index }, alert: "User account is already confirmed!") }
        end
      end
    end
  end
end

