class Mailer < ActionMailer::Base
  default :from => "register@riverwest24.com", :content_type => "text/plain"

  def confirmation_email team
    @team = team
    mail :to => team.captain_email,
      :cc => team.lieutenant_emails,
      :subject => "Riverwest 24 #{team.race.year}: #{team.position} - #{team.name}"
      "RW24 #{team.race.year} Confirmation: #{team.name} (##{team.position}) - #{team.category} - Shirts: #{team.shirt_sizes}"
  end
end
