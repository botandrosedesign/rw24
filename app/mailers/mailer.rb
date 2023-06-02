class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def confirmation_email team
    @team = team
    @body = team.site.confirmation_email_body
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
end
