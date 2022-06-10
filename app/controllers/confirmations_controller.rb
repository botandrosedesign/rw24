class ConfirmationsController < BaseController
  include Authentication::HashHelper

  before_action :guess_section

  def show
    if user = User.find_by_verification_key(hash_string(params[:id]))
      user.update_column :verified_at, (user.verified_at || Time.zone.now)
      session[:uid] = user.id
      set_user_cookie!(user)
      flash.notice = "Welcome, #{user.name}! You have created your profile."
    else
      flash.alert = "Bad confirmation key"
    end
    redirect_to "/"
  end
end

