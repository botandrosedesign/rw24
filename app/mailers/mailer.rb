class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def registration user, key, host
    @user = user
    @link = account_confirmation_url(id: key, host: host)
    mail from: "info@riverwest24.com", to: user.email, subject: "Welcome to Riverwest24"
  end
end
