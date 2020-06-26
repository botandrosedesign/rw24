class AccountsController < BaseController
  before_action :guess_section

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      Authentication::SingleToken.new.assign_token(@user, nil, 1.month.from_now)
      @user.save!
      Mailer.registration(@user, request.host_with_port).deliver_now
      redirect_to "/", notice: "A confirmation email has been sent to #{@user.email}"
    else
      render({ action: :new }, alert: @user.errors.full_messages)
    end
  end

  def update
    @user = current_user
    if @user.update(update_user_params)
      redirect_to "/", notice: "Account updated"
    else
      render({ action: :show }, alert: @user.errors.full_messages)
    end
  end

  private

  def create_user_params
    params.require(:user).permit(
      :email,
      :password,
      :first_name,
      :last_name,
      :phone,
      :shirt_size,
    )
  end

  def update_user_params
    create_user_params.tap { |p| p.delete(:email) }
  end
end

