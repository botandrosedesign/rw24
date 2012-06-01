class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def confirmation_email team
    @team = team
    mail :to => team.captain_email,
      :cc => team.lieutenant_emails,
      :content_type => "text/plain",
      :subject => "RW24 #{team.race.year} Confirmation: #{team.name} (##{team.position}) - #{team.category} - Shirts: #{team.shirt_sizes}"
  end
end
