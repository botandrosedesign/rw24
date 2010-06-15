class RegistrationMailer < ActionMailer::Base
  def registration(team)
    recipients   team.riders.collect(&:email).reject(&:blank?)
    from         "register@riverwest24.com"
    subject      "Riverwest 24 2010 - Team signup confirmation"
    body         :team => team
    content_type "text/html"
  end
end
