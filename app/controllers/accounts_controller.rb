class AccountsController < BaseController
  before_action :verify_turnstile, only: :create
  before_action :guess_section

  def new
    @user = User.new
  end

  def show
    @team = current_user.team_for(Race.current)
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      @user.generate_verification_key!
      Mailer.registration(@user, @user.unhashed_verification_key, request.host_with_port).deliver_now
      flash.now.notice = "A confirmation email has been sent to #{@user.email}"
    else
      if @user.errors.messages[:email].include?("has already been taken") && !(existing_user = User.find_by_email!(@user.email)).verified?
        existing_user.generate_verification_key!
        Mailer.registration(existing_user, existing_user.unhashed_verification_key, request.host_with_port).deliver_now
        redirect_to "/", alert: "Profile already exists but is unconfirmed. A confirmation email has been sent to #{existing_user.email}"
      else
        flash.now.alert = @user.errors.full_messages.join(", ")
        render action: :new
      end
    end
  end

  def update
    @user = current_user
    if @user.update(update_user_params)
      redirect_to "/", notice: "Account updated"
    else
      flash.now.alert = @user.errors.full_messages.join(", ")
      render action: :show
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

  def verify_turnstile
    response = Net::HTTP.post_form(
      URI("https://challenges.cloudflare.com/turnstile/v0/siteverify"),
      "secret" => Rails.application.config.turnstile_secret_key,
      "response" => params["cf-turnstile-response"],
    )
    return if JSON.parse(response.body)["success"]

    @user = User.new(create_user_params)
    flash.now.alert = "CAPTCHA verification failed. Please try again."
    render action: :new, status: :unprocessable_entity
  end
end

