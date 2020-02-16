class ConfirmationsController < BaseController
  before_action :guess_section

  def show
    single_token = Authentication::SingleToken.new
    token_key = params[:id]
    if user = User.find_by_token_key(params[:id])
      user.update_column :verified_at, (user.verified_at || Time.zone.now)
      session[:uid] = user.id
      set_user_cookie!(user)
      flash.notice = "Welcome, #{user.name}! You have completed the registration process."
    else
      flash.alert = "Bad confirmation key"
    end
    redirect_to "/"
  end
end

