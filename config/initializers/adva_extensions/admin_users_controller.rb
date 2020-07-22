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
        redirect_to({ action: :index }, notice: "Confirmation email resent to #{user.email}")
      else
        redirect_to({ action: :index }, alert: "User account is already confirmed!")
      end
    end
  end
end

