class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com"

  def confirmation_email team
    @team = team
    mail :to => team.captain_email,
      :cc => team.lieutenant_emails,
      :subject => "Riverwest 24 #{team.race.year}: #{team.position} - #{team.name}"
  end
end
