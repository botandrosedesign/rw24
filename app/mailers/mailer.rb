class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def confirmation_email team
    @team = team
    @body = team.site.confirmation_email_body
    mail :to => team.captain_email,
      :cc => team.lieutenant_emails,
      :content_type => "text/plain",
      :reply_to => "register@riverwest24.com",
      :subject => "RW24 #{team.race.year} Confirmation: #{team.name} (##{team.position}) - #{team.category} - Shirts: #{team.shirt_sizes.summary}"
  end
end
