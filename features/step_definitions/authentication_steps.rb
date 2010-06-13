Given /^the "Admin" user account exists$/ do
  user = User.make :first_name => "Micah",
    :last_name => "Geisel",
    :email => "micah@botandrose.com",
    :password => "secret"
  user.roles << Rbac::Role.new(:name => "superuser")
  @site.users << user
end

Given /^I am logged in as an Admin$/ do
  Given 'the "Admin" user account exists'
  And 'I am on the admin page'
  And 'I fill in "Email" with "micah@botandrose.com"'
  And 'I fill in "Password" with "secret"'
  And 'I press "Login"'
  And 'I am on the admin overview page'
end

