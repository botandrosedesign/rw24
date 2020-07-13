ActiveSupport::Reloader.to_prepare do
  Admin::UsersController.class_eval do
    skip_before_action :set_users, only: :index

    def index
      @users = User.all
      @user_teams = UserTeams.new
    end
  end
end

