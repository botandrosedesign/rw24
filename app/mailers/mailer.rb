class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def confirmation_email team
    @team = team
    @body = Site.first.confirmation_email_body
    mail :to => team.captain_email,
      :cc => team.lieutenant_emails,
      :content_type => "text/plain",
      :reply_to => "register@riverwest24.com",
      :subject => "RW24 #{team.race.year} Confirmation: #{team.name} (##{team.position}) - #{team.category_name} - Shirts: #{team.shirt_sizes.summary}"
  end

  def registration user, key, host
    @user = user
    @link = account_confirmation_url(id: key, host: host)
    mail from: "info@riverwest24.com", to: user.email, subject: "Welcome to Riverwest24"
  end

  def change_email user, token, host
    @user = user
    @confirmation_url = confirmation_account_email_url(token: token, host: host)
    mail from: "info@riverwest24.com", to: user.new_email, subject: "Request to change riverwest24.com email address"
  end
end
