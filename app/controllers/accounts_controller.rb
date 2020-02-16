class AccountsController < BaseController
  before_action :guess_section

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Authentication::SingleToken.new.assign_token(@user, nil, 1.month.from_now)
      @user.save!
      Mailer.registration(@user, request.host_with_port).deliver_now
      redirect_to "/", notice: "A confirmation email has been sent to #{@user.email}"
    else
      render({ action: :new }, alert: @user.errors.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :phone,
      :shirt_size,
    )
  end
end

