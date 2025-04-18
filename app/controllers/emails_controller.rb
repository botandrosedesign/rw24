class EmailsController < BaseController
  include Authentication::HashHelper

  expose :user

  def show
    @user = current_user
  end

  def create
    @user = current_user
    PreparesUpdatesUserEmailAddress.execute @user, params[:new_email], request.host_with_port
  rescue PreparesUpdatesUserEmailAddress::Error => e
    flash.alert = e.message
    redirect_to action: :show
  end

  def confirmation
    @user = User.find_by_verification_key(hash_string(params[:token]))
    if @user
      if @user.update email: @user.new_email, new_email: nil, verification_key: nil
        session[:uid] = user.id
        set_user_cookie!(user)
        flash.notice = "Welcome, #{@user.email}! You have successfully changed your email address."
      else
        flash.alert = "There is already an user with this email address!"
      end
    else
      flase.alert = "Bad confirmation token!"
    end
    redirect_to root_path
  end
end
