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
    redirect_to :show, alert: e.message
  end

  def confirmation
    @user = User.find_by_verification_key(hash_string(params[:token]))
    if @user
      if @user.update email: @user.new_email, new_email: nil, verification_key: nil
        session[:uid] = user.id
        set_user_cookie!(user)
        redirect_to root_path, notice: "Welcome, #{@user.email}! You have successfully changed your email address."
      else
        redirect_to root_path, alert: "There is already an user with this email address!"
      end
    else
      redirect_to root_path, alert: "Bad confirmation token!"
    end
  end
end
